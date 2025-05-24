function __fish_dotfiles_modules
    for dir in ~/.dotfiles/*
        if test -d "$dir"
            echo (basename "$dir")
        end
    end
end

complete -c dotfiles -f -a "(__fish_dotfiles_modules)" -d "dotfiles module"
