# rolo - rolodex program to look up, add, and
#        remove people from the phone book
#
# Set PHONEBOOK to point to the phone book file
# and export it so other progs know about it
#
PHONEBOOK=./phonebook
export PHONEBOOK
if [ ! -f "$PHONEBOOK" ]; then
  echo "No phone book file in $HOME!"
  exit 1
fi

# If arguments are supplied, then do a lookup
if [ "$#" -ne 0 ]; then
  lu "$@"
  exit
fi
validchoice="" # set it null

# Loop until a valid selection is made
until [ -n "$validchoice" ]; do

  # Display menu
  echo '
       Would you like to:
       1. Look someone up
       2. Add someone to the phone book
       3. Remove someone from the phone book
Please select one of the above (1-3): \c'

  # Read and process selection
  read choice
  echo
  case "$choice" in
  1)
    echo -n "Enter name to look up: "
    read name
    lu "$name"
    validchoice=TRUE
    ;;
  2)
    echo -n "Enter name to be added: "
    read name
    echo -n "Enter number: "
    read number
    add "$name" "$number"
    validchoice=TRUE
    ;;
  3)
    echo -n "Enter name to be removed: "
    read name
    rem "$name"
    validchoice=TRUE
    ;;
  *) echo "Bad choice" ;;
  esac
done
$ cat add

# Program to add someone to the phone book file
if [ "$#" -ne 2 ]; then
  echo "Incorrect number of arguments"
  echo "Usage: add name number"
  exit 1
fi
echo "$1       $2" >>$PHONEBOOK
sort -o $PHONEBOOK $PHONEBOOK
