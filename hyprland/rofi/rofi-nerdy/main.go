package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"sort"
)

type Glyph struct {
	Char string `json:"char"`
	Code string `json:"code"`
}

type GlyphNames map[string]Glyph

type Icon struct {
	Icon string
	Name string
}

const glyphNamesURL = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json"

func main() {
	glyphNames := GlyphNames{}

	resp, err := http.Get(glyphNamesURL)
	if err != nil {
		fmt.Printf("Error getting glyph names: %v", err)
		os.Exit(1)
	}
	defer resp.Body.Close()

	if err := json.NewDecoder(resp.Body).Decode(&glyphNames); err != nil {
		fmt.Printf("Error unmarshalling glyph names: %v", err)
		os.Exit(1)
	}

	if err := os.Truncate("./emojis.list", 0); err != nil {
		fmt.Printf("Error truncating file: %v", err)
	}

	icons := []Icon{}

	for key, value := range glyphNames {
		if key == "METADATA" {
			continue
		}
		icons = append(icons, Icon{Icon: value.Char, Name: key})
	}

	sort.Slice(icons, func(i, j int) bool {
		return icons[i].Name < icons[j].Name
	})

	outFile, err := os.OpenFile("./emojis.list", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		fmt.Printf("Error opening file: %v", err)
		os.Exit(1)
	}
	defer outFile.Close()

	for _, icon := range icons {
		outFile.WriteString(icon.Icon + " " + icon.Name + "\n")
	}
}
