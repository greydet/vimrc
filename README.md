Install
=======
1. Clone this repository:

        git clone git://github.com/greydet/vimrc.git ~/vimrc

2. Create a symbolic link to the vimrc file

        ln -s ~/vimrc/vimrc ~/.vimrc

Configuration customization
===========================
As some configurations can be very user or system dependant, users can put a `.vimrc.custom` file at the root of their home directory to add their specific vim customizations. This file will be automatically sourced by this vimrc script.

Code navigation configuration
=============================
Cscope
------
When editing a C/C++ source or header file, a `cscope.out` file is recusively searched in the parent directories to the filesystem root. This cscope database file is used for code navigation and code completion (cscope, CCTree plugin, ...)
The cscope database file can be generated with the following command:
    cscope -bcv *.c *.h
Ctags
-----
Ctags database file can also be used the same way. They are generated with the following command line:
    ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf *.c *.h
