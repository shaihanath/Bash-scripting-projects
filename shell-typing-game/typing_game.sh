#!/bin/bash

# SHELL TYPING GAME

# ---------- Colors ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# ---------- Score File ----------
SCORE_FILE="$HOME/.typing_game_scores"


# ---------- Banner ----------
print_banner() {
    clear

    cat << "EOF"
 _______            _              _____
|__   __|          (_)            / ____|
   | |_   _ _ __  _ _ __   __ _  | |  __  __ _ _ __ ___   ___
   | | | | | '_ \| | '_ \ / _` | | | |_ |/ _` | '_ ` _ \ / _ \
   | | |_| | |_) | | | | | (_| | | |__| | (_| | | | | | |  __/
   |_|\__, | .__/|_|_| |_|\__, |  \_____|\__,_|_| |_| |_|\___|
       __/ | |             __/ |
      |___/|_|            |___/
EOF

    echo
}


# ---------- Generate Random Character ----------
generate_char() {

    local mode=$1

    case "$mode" in

        numbers)
            echo $(( RANDOM % 10 ))
            ;;

        letters)
            chars=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
            echo "${chars[$((RANDOM % 26))]}"
            ;;

        mixed)
            if (( RANDOM % 2 == 0 )); then
                echo $(( RANDOM % 10 ))
            else
                chars=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
                echo "${chars[$((RANDOM % 26))]}"
            fi
            ;;

        words)
            word_list=("bash" "linux" "devops" "server" "script" "cloud" "kernel" "docker")
            echo "${word_list[$((RANDOM % ${#word_list[@]}))]}"
            ;;

        *)
            echo "Invalid mode"
            return 1
            ;;
    esac
}


# ---------- Normal Round ----------
play_round() {

    local mode=$1

    target=$(generate_char "$mode")

    echo
    echo -e "${CYAN}Type this: ${YELLOW}$target${NC}"

    read -p "> " user_input

    if [[ "$user_input" == "$target" ]]; then

        echo -e "${GREEN}✅ Correct!${NC}"
        return 0

    else

        echo -e "${RED}❌ Wrong!${NC}"
        echo "You typed: '$user_input'"
        echo "Expected: '$target'"

        return 1
    fi
}


# ---------- Difficulty ----------
declare -A DIFFICULTY=(
    [easy]=5
    [medium]=3
    [hard]=1
)


# ---------- Timed Round ----------
play_round_timed() {

    local mode=$1
    local time_limit=$2

    target=$(generate_char "$mode")

    echo
    echo -e "${CYAN}Type this within ${time_limit}s: ${YELLOW}$target${NC}"

    if read -t "$time_limit" -p "> " user_input; then

        if [[ "$user_input" == "$target" ]]; then

            echo -e "${GREEN}✅ Correct!${NC}"
            return 0

        else

            echo -e "${RED}❌ Wrong!${NC}"
            echo "Expected: '$target'"

            return 1
        fi

    else

        echo
        echo -e "${YELLOW}⏰ Time's up!${NC}"

        return 1
    fi
}


# ---------- Play Normal Game ----------
play_game() {

    local mode=$1
    local rounds=${2:-5}

    score=0

    for (( i=1; i<=rounds; i++ )); do

        echo
        echo "----------------------------"
        echo "Round $i of $rounds"
        echo "----------------------------"

        if play_round "$mode"; then
            ((score++))
        fi

    done

    echo
    echo "=========================="
    echo -e "${CYAN}Game Over!${NC}"
    echo "Score: $score/$rounds"
    echo "=========================="
}


# ---------- Play Timed Game ----------
play_game_timed() {

    local mode=$1
    local difficulty=$2
    local rounds=${3:-5}

    local time_limit=${DIFFICULTY[$difficulty]}

    score=0

    for (( i=1; i<=rounds; i++ )); do

        echo
        echo "----------------------------"
        echo "Round $i of $rounds"
        echo "Difficulty: $difficulty"
        echo "Round $i of $rounds"
        echo "----------------------------"

        if play_round_timed "$mode" "$time_limit"; then
            ((score++))
        fi

    done

    echo
    echo "=========================="
    echo -e "${CYAN}Final Score: $score/$rounds${NC}"
    echo "=========================="
}


# ---------- Save Score ----------
save_score() {

    local name=$1
    local score=$2
    local rounds=$3

    echo "$(date '+%Y-%m-%d %H:%M:%S') | $name | $score/$rounds" >> "$SCORE_FILE"
}


# ---------- Show High Scores ----------
show_high_scores() {

    echo
    echo "=========================="
    echo "       HIGH SCORES"
    echo "=========================="

    if [[ -f "$SCORE_FILE" ]]; then

        sort -t'/' -k1 -nr "$SCORE_FILE" | head -5

    else

        echo "No scores yet!"
        echo "Play a game first."

    fi
}


# ---------- Main Menu ----------
show_menu() {

    print_banner

    echo "========================================"
    echo "         SHELL TYPING GAME"
    echo "========================================"
    echo "1) Practice Numbers"
    echo "2) Practice Letters"
    echo "3) Mixed (Letters + Numbers)"
    echo "4) Custom Words"
    echo "5) Exit"
    echo "========================================"

    read -p "Choose a mode [1-5]: " mode_choice
}


# ---------- Difficulty Menu ----------
choose_difficulty() {

    echo
    echo "=========================="
    echo "      DIFFICULTY"
    echo "=========================="
    echo "1) Easy   - 5 seconds"
    echo "2) Medium - 3 seconds"
    echo "3) Hard   - 1 second"
    echo "=========================="

    read -p "Choose difficulty [1-3]: " difficulty_choice

    case "$difficulty_choice" in

        1)
            difficulty="easy"
            ;;

        2)
            difficulty="medium"
            ;;

        3)
            difficulty="hard"
            ;;

        *)
            echo -e "${RED}Invalid difficulty.${NC}"
            return 1
            ;;
    esac
}


# ==========================================
# MAIN PROGRAM
# ==========================================

show_menu


# ---------- Validate Menu ----------
if ! [[ "$mode_choice" =~ ^[1-5]$ ]]; then

    echo -e "${RED}Invalid input. Please enter a number 1-5.${NC}"
    exit 1

fi


# ---------- Select Mode ----------
case "$mode_choice" in

    1)
        mode="numbers"
        ;;

    2)
        mode="letters"
        ;;

    3)
        mode="mixed"
        ;;

    4)
        mode="words"
        ;;

    5)
        echo "Goodbye!"
        exit 0
        ;;

esac


# ---------- Number of Rounds ----------
echo
read -p "How many rounds? [default 5]: " rounds

if [[ -z "$rounds" ]]; then
    rounds=5
fi

if ! [[ "$rounds" =~ ^[0-9]+$ ]] || (( rounds < 1 )); then
    echo -e "${RED}Invalid number of rounds.${NC}"
    exit 1
fi


# ---------- Difficulty ----------
choose_difficulty || exit 1


# ---------- Start Game ----------
echo
echo -e "${CYAN}Starting game...${NC}"
sleep 2

play_game_timed "$mode" "$difficulty" "$rounds"


# ---------- Save Score ----------
echo
read -p "Enter your name: " player_name

if [[ -z "$player_name" ]]; then
    player_name="Player"
fi

save_score "$player_name" "$score" "$rounds"


# ---------- Display Scores ----------
show_high_scores

echo
echo "Thanks for playing!"
