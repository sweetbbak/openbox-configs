#!/usr/bin/env bash
#
# Quick script to get language translations
# using the DeepL.com free API
#
# This requires:
# - an account/API key for https://deepl.com
# - the API key in $HOME/.deepl/credentials like so: AUTH_KEY=xxx


# Set colours
NC='\033[0m'
RED='\033[0;31m'

# shellcheck source=/dev/null
source "$HOME/.deepl/credentials"  # Contains "AUTH_KEY=xxx"
ENDPOINT=https://api-free.deepl.com/v2/translate  # Change if you pay for pro

# Helpers
error() {
  # shellcheck disable=SC2059  # for clarity instead of format specifiers
  printf "${RED}ERROR ${NC}- $*\n" >&2
}

usage() {
  local script_name
  script_name=$(basename "$0")
  cat <<EOF
USAGE: $script_name [ TEXT ] [ LANGUAGE ]
e.g. $script_name Hello world french
Supported languages:
BG BULGARIAN
CS CZECH
DA DANISH
DE GERMAN
EL GREEK
EN-GB BRITISH
EN-US AMERICAN
EN ENGLISH
ES SPANISH
ET ESTONIAN
FI FINNISH
FR FRENCH
HU HUNGARIAN
IT ITALIAN
JA JAPANESE
LT LITHUANIAN
LV LATVIAN
NL DUTCH
PL POLISH
PT-PT PORTUGUESE
PT-BR BRAZILIAN
PT PORTUGUESE-ALL
RO ROMANIAN
RU RUSSIAN
SK SLOVAK
SL SLOVENIAN
SV SWEDISH
ZH CHINESE
EOF
}

# Main #########################################################################

if [[ $# -lt 2 ]] ; then
    error "Not enough arguments"
    usage
    exit 1
fi

# Work out target language
 TARGET_LANG=${*:$#}  # last argument
case "${TARGET_LANG^^}" in  # make sure TARGET_LANG is uppercase
  BG|BULGARIAN)       TARGET_LANG=BG ;;
  CS|CZECH)           TARGET_LANG=CS ;;
  DA|DANISH)          TARGET_LANG=DA ;;
  DE|GERMAN)          TARGET_LANG=DE ;;
  EL|GREEK)           TARGET_LANG=EL ;;
  EN-GB|BRITISH)      TARGET_LANG=EN-GB ;;
  EN-US|AMERICAN)     TARGET_LANG=EN-US ;;
  EN|ENGLISH)         TARGET_LANG=EN ;;
  ES|SPANISH)         TARGET_LANG=ES ;;
  ET|ESTONIAN)        TARGET_LANG=ET ;;
  FI|FINNISH)         TARGET_LANG=FI ;;
  FR|FRENCH)          TARGET_LANG=FR ;;
  HU|HUNGARIAN)       TARGET_LANG=HU ;;
  IT|ITALIAN)         TARGET_LANG=IT ;;
  JA|JAPANESE)        TARGET_LANG=JA ;;
  LT|LITHUANIAN)      TARGET_LANG=LT ;;
  LV|LATVIAN)         TARGET_LANG=LV ;;
  NL|DUTCH)           TARGET_LANG=NL ;;
  PL|POLISH)          TARGET_LANG=PL ;;
  PT-PT|PORTUGUESE)   TARGET_LANG=PT-PT ;;
  PT-BR|BRAZILIAN)    TARGET_LANG=PT-BR ;;
  PT|PORTUGUESE-ALL)  TARGET_LANG=PT ;;
  RO|ROMANIAN)        TARGET_LANG=RO ;;
  RU|RUSSIAN)         TARGET_LANG=RU ;;
  SK|SLOVAK)          TARGET_LANG=SK ;;
  SL|SLOVENIAN)       TARGET_LANG=SL ;;
  SV|SWEDISH)         TARGET_LANG=SV ;;
  ZH|CHINESE)         TARGET_LANG=ZH ;;
  -h|--help)
    usage
    exit 2
    ;;
  *)
    error "Invalid or unsupported language"
    exit 1
    ;;
esac

# Treat every other argument as text to be translated
TEXT=("${@:1:$# -1}")  # all arguments except the last

# TODO: make more elegant
response=$(curl -s "$ENDPOINT" \
	-d auth_key="${AUTH_KEY}" \
	-d "text=${TEXT[*]}"  \
	-d "target_lang=${TARGET_LANG}")

# TODO: check exit code directly
if [ $? -eq 0 ]; then
    RES_TEXT=$(echo "$response" | jq .translations[0].text | tr -d '"')
    SOURCE_LANG=$(echo "$response" | jq .translations[0].detected_source_language | tr -d '"')
    echo "Translation from $SOURCE_LANG to $TARGET_LANG:"
    echo "$RES_TEXT"
else
  error "Something went wrong..."
fi
