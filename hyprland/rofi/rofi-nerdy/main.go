package main

import (
	"bytes"
	"fmt"
	"os"
	"strconv"

	"golang.org/x/net/html"
)

type Icon struct {
	Icon string
	Name string
}

func main() {
	file, err := os.ReadFile("./nerd.html")
	if err != nil {
		fmt.Printf("Error reading file: %v", err)
	}

	doc := parseHtml(file)
	mainNode := getMainNode(doc)

	icons := []Icon{}

	for elem := mainNode.FirstChild; elem != nil; elem = elem.NextSibling {
		if elem.Data == "div" {
			for _, attr := range elem.Attr {
				if attr.Key == "class" && attr.Val == "column" {
					parseColumn(elem, &icons)
				}
			}
		}
	}

	if err := os.Truncate("./emojis.lst", 0); err != nil {
		fmt.Printf("Error truncating file: %v", err)
	}

	outFile, err := os.OpenFile("./emojis.lst", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		fmt.Printf("Error opening file: %v", err)
		os.Exit(1)
	}
	defer outFile.Close()

	for _, icon := range icons {
		outFile.WriteString(icon.Icon + " " + icon.Name + "\n")
	}
}

func parseHtml(file []byte) *html.Node {
	doc, err := html.Parse(bytes.NewReader(file))
	if err != nil {
		fmt.Printf("Error parsing HTML: %v", err)
		os.Exit(1)
	}

	return doc
}

func getMainNode(doc *html.Node) *html.Node {
	htmlNode := doc.FirstChild
	bodyNode := htmlNode.LastChild
	return bodyNode.FirstChild
}

func parseColumn(columnElem *html.Node, icons *[]Icon) {
	icon := Icon{}

	for node := columnElem.FirstChild; node != nil; node = node.NextSibling {
		for _, attr := range node.Attr {
			if attr.Key == "class" && attr.Val == "codepoint" {
				str, err := strconv.Unquote(`"\u` + node.FirstChild.Data + `"`)
				if err != nil {
					fmt.Printf("Error decoding hex string: %v", err)
					os.Exit(1)
				}

				icon.Icon = string(str)
			}
			if attr.Key == "class" && attr.Val == "class-name" {
				icon.Name = node.FirstChild.Data
			}
		}
	}

	if columnElem.Data == "div" {
		*icons = append(*icons, icon)
	}
}
