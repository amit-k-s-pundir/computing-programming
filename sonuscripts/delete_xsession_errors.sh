#!/bin/bash
# deletes ~/.xsession-errors at startup so it does not write gigabytes of debug info
rm -f ~/.xsession-errors
touch ~/.xsession-errors
sudo chattr -i ~/.xsession-errors
