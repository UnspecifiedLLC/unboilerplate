import sys

print("Hello from '{}'".format(__name__))

print('sys.path contents:')
for p in sys.path:
    print("'{}'".format(p))
print('end sys.path contents')
