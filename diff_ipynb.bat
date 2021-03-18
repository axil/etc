git show master:%1 >%~n1-orig.ipynb
python clean_ipynb.py %~n1-orig.ipynb %1
git diff %~n1-orig.py %~n1.py
