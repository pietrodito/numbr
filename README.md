# numbr
A R package to keep your script ordered with leading numbers in file names.
_____

This is an example of how I keep my scripts organized when I analyze some data:

```
# ls R/
01-import.R
02-data-management.R
03-imputation.R
04-table-1.R
05-figure-1.R
...
11-figure-supp-4.R
```

There are several advantages to that. The pain is when you want to delete or insert a file in this list and keep it organized.


This is why this packages is here.


```
> library(numbr)
> create_ordered_script("import")
> create_ordered_script("data-management")
> create_ordered_script("table-1")
> insert_script_at(3, "imputation")
```
After that, you will have :
```
# ls R/
1-import.R
2-data-management.R
3-imputation.R
4-table-1.R
```

You can source all scripts with `run_numbered_scripts()`


Leading zeros are added when you have more than 10 or 100 scripts.


The package plays well in RStudio, because when you create a script it opens it, and when you run all scripts, all modified files are automaticaly saved. 
