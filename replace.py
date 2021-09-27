#!/usr/bin/python

import os
import sys
import getopt

def main(argv):
    helptext = 'replace.py -o old -n new'
    old = ''
    new = ''
    counter = 0

    try:
        opts, args = getopt.getopt(argv, "ho:n:", ["old=", "new="])
    except getopt.GetoptError:
        print(helptext)
        sys.exit(2)

    if not opts:
        print(helptext)
        sys.exit()

    for opt, arg in opts:
        if opt == '-h':
            print(helptext)
            sys.exit()
        elif opt in ("-o", "--old"):
            old = arg
        elif opt in ("-n", "--new"):
            new = arg
    print('\nOld was ' + old)
    print('New is ' + new + '\n')

    for root, dirs, files in os.walk("."):
        for file in files:
            filepath = os.path.join(root, file)
            if '.git' not in filepath and 'replace.py' not in filepath:
                with open(filepath, 'r') as f:
                    data = f.read()
                    if old in data:
                        print(filepath)
                        counter += data.count(old)
                        print(counter)
                        data = data.replace(old, new)
                        f.close()

                        with open(filepath, 'w') as fi:
                            fi.write(data)
                            fi.close()


if __name__ == "__main__":
    main(sys.argv[1:])
