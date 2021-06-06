start_procedure() {
    echo "${light}Installing $TARGET and Configurations${reset}"
}

check_procedure() {
    APP=$1
    if dpkg -s “$name” &> /dev/null ; then
        echo "$TARGET already installed. Using existing version of $TARGET..."
    else
        echo "Installing $TARGET from the APT-Store...XD"
        sudo apt install $APP
    fi
}

endof_procedure() {
    echo "${light}$TARGET Configurations Completed!${reset}"
}
