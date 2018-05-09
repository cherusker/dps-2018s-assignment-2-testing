#!/bin/bash

# ------------------------------------------------------------------------------
# adjust the following settings to match your setup:

dlvexe="../dlv/dlv.x86-64-linux-elf-static.bin"

guessTestsRootFolder="guess-tests/"
checkTestsRootFolder="check-tests/"

guessProgram="../code/guess.dl"
checkProgram="../code/check.dl"

runGuessTests="1" # 0 = no, 1 = yes
runCheckTests="1" # 0 = no, 1 = yes
stopOnFailure="1" # 0 = no, 1 = yes

# ------------------------------------------------------------------------------
# defines:

ansiStyleReset="\033[0m"
ansiStyleRedBold="\033[1;31m"
ansiStyleGreen="\033[0;32m"

# ------------------------------------------------------------------------------
# test execution logic:

succCounter="0"
failCounter="0"

if [[ "${runGuessTests}" == "1" ]]; then
    for inFile in "${guessTestsRootFolder}"*; do
        if [[ "${inFile: -3}" != ".dl" ]]; then
            continue
        fi
        printf "Testing: %s ..." "${inFile}"
        outFile="${inFile}.out"
        "${dlvexe}" -silent \
                    -N=300 \
                    "${guessProgram}" \
                    "${inFile}" > "${outFile}"
        read lines name <<< $(wc -l "${outFile}")
        if [[ "${inFile}" == *"-${lines}.dl" ]]; then
            succCounter=$((succCounter+1))
            printf " ${ansiStyleGreen}OK${ansiStyleReset}\n"
        else
            failCounter=$((failCounter+1))
            printf " ${ansiStyleRedBold}failed${ansiStyleReset}\n"
            if [[ "${stopOnFailure}" == "1" ]]; then
                break
            fi
        fi
    done
fi

if [[ "${runCheckTests}" == "1" ]]; then
    for inFile in "${checkTestsRootFolder}"*; do
        if [[ "${inFile: -3}" != ".dl" ]]; then
            continue
        fi
        printf "Testing: %s ..." "${inFile}"
        outFile="${inFile}.out"
        "${dlvexe}" -silent \
                    -N=300 \
                    "${checkProgram}" \
                    "${inFile}" > "${outFile}"
        read lines name <<< $(wc -l "${outFile}")
        if [[ "${inFile: -6}" == "yes.dl" ]] && [[ "${lines}" == "1" ]]; then
            succCounter=$((succCounter+1))
            printf " ${ansiStyleGreen}OK${ansiStyleReset}\n"
        elif [[ "${inFile: -5}" == "no.dl" ]] && [[ "${lines}" == "0" ]]; then
            succCounter=$((succCounter+1))
            printf " ${ansiStyleGreen}OK${ansiStyleReset}\n"
        else
            failCounter=$((failCounter+1))
            printf " ${ansiStyleRedBold}failed${ansiStyleReset}\n"
            if [[ "${stopOnFailure}" == "1" ]]; then
                break
            fi
        fi
    done
fi

printf "\n  succesful tests: ${ansiStyleGreen}%d${ansiStyleReset}\n" "${succCounter}"
printf "     failed tests: ${ansiStyleRedBold}%d${ansiStyleReset}\n\n" "${failCounter}"
