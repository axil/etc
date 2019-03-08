@assoc .whl=pythonwheel || echo Run me with administrator rights! && pause && exit 1
@ftype pythonwheel=cmd /c pip.exe install "%%1" ^& pause || echo Installation error && pause && exit 1
@echo Installation successful & pause
