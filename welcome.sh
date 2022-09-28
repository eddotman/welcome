#!/bin/bash
# this was obviously originally written for internal use at Cohere to welcome folks to
# their computer each morning/afternoon, should be trivial to adjust the prompt/options
# to whatever you want!

STATIC=0
COHERE_KEY="YOUR API KEY FROM OS.COHERE.AI"

if [[$STATIC]]; then
    morning="Good morning, I hope u have a rly good day (◕‿◕✿)
    Good morning, I hope u slept well (◕‿◕✿)
    you mean a lot to me (◕‿◕✿)
    (づ￣ ³￣)づ Good morning, I missed you!
    (づ￣ ³￣)づ Good morning, Cohere awaits!
    (づ￣ ³￣)づ Good morning!
    (｡◕‿◕｡) you look lovely today
    (｡◕‿◕｡) It’s gonna be a rly good day today
    (｡◕‿◕｡) did you sleep well? remem u need 6-9 hours each night!
    (づ｡◕‿‿◕｡)づ big things gonna happen today!!
    (づ｡◕‿‿◕｡)づ gm, im very proud of u
    (づ｡◕‿‿◕｡)づ gm, how’d you sleep?
    ༼ つ ಥ_ಥ ༽つ pls give me coffee"

    afternoon="༼ つ ◕_◕ ༽つ within lies great power. go forth and seek your parameters.
    ༼ つ ◕_◕ ༽つ today, you shall discover your true power
    ༼ つ ◕_◕ ༽つ behold... Caleb      ▼・ᴥ・▼ <( woof )
    ʕ•ᴥ•ʔ co:mfy time
    ʕ•ᴥ•ʔ im a bear
    u look rly nice today (◕‿◕✿)
    Cheer time.. 1! 2! 3! CooHeErrE (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧
    (づ￣ ³￣)づ I MISSED YOU SO MUCH THANK YOU FOR COMING BACKK ADFJSLDJF
    (づ￣ ³￣)づ YOU’RE BACK!!! ADFJSLDJF
    COHEEEERRREEEE (｡◕‿◕｡)
    | (• ◡•)| COHERE TIME! (❍ᴥ❍ʋ)
    ༼ つ ಥ_ಥ ༽つ U r my hero
    (~˘▾˘)~ PARAMETERS ~(˘▾˘~)
    im baby (◕ ˬ ◕✿)"

    currenttime=$(date +%H:%M)
    if [[ "$currenttime" > "01:00" ]] && [[ "$currenttime" < "12:00" ]]; then
        msg=$(echo "$morning" | sort -R | head -n 1)
    else
        msg=$(echo "$afternoon" | sort -R | head -n 1)
    fi
else
    msg=$(curl --location --request POST 'https://api.cohere.ai/generate' \
    --header "Authorization: BEARER ${COHERE_KEY}" \
    --header 'Content-Type: application/json' \
    --header 'Cohere-Version: 2021-11-08' \
    --data-raw '{
        "model": "xlarge",
        "prompt": "List of cute welcome phrases:\n- Good morning, I hope u have a rly good day (◕‿◕✿)\n- Good morning, I hope u slept well (◕‿◕✿)\n- you mean a lot to me (◕‿◕✿)\n- (づ￣ ³￣)づ Good morning, I missed you!\n- (づ￣ ³￣)づ Good morning, Cohere awaits!\n- (づ￣ ³￣)づ Good morning!\n- (｡◕‿◕｡) you look lovely today\n- (｡◕‿◕｡) It’s gonna be a rly good day today\n- (｡◕‿◕｡) did you sleep well? remem u need 6-9 hours each night!\n- (づ｡◕‿‿◕｡)づ big things gonna happen today!!\n- (づ｡◕‿‿◕｡)づ gm, im very proud of u\n- (づ｡◕‿‿◕｡)づ gm, how’d you sleep?\n- ༼ つ ಥ_ಥ ༽つ pls give me coffee\n- ༼ つ ◕_◕ ༽つ within lies great power. go forth and seek your parameters.\n- ༼ つ ◕_◕ ༽つ today, you shall discover your true power\n- ༼ つ ◕_◕ ༽つ behold... Caleb   ▼・ᴥ・▼ <( woof )\n- ʕ•ᴥ•ʔ co:mfy time\n- ʕ•ᴥ•ʔ im a bear\n- u look rly nice today (◕‿◕✿)\n- Cheer time.. 1! 2! 3! CooHeErrE (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧\n- (づ￣ ³￣)づ I MISSED YOU SO MUCH THANK YOU FOR COMING BACKK ADFJSLDJF\n- (づ￣ ³￣)づ YOU’RE BACK!!! ADFJSLDJF\n- COHEEEERRREEEE (｡◕‿◕｡)\n- | (• ◡•)| COHERE TIME! (❍ᴥ❍ʋ)\n- ༼ つ ಥ_ಥ ༽つ U r my hero\n- (~˘▾˘)~ PARAMETERS ~(˘▾˘~)\n- im baby (◕ ˬ ◕✿)\n- your voice is so sweet (◕ ˬ ◕✿)\n-", 
        "max_tokens": 10,
        "temperature": 0.9,
        "k": 0,
        "p": 0.75,
        "frequency_penalty": 0,
        "presence_penalty": 0,
        "stop_sequences": ["\n"],
        "return_likelihoods": "NONE",
        "language": "en"
        }' | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["generations"][0]["text"].strip());')
fi

echo $msg

defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "${msg}" || defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "'${msg}'"
