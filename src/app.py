import sys

print(sys.version)

def main():
    import os
    value = os.path.dirname(__file__)
    print(value)


if __name__ == '__main__':
    main()