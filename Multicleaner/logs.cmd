for /F "tokens=*" %%G in ('wevtutil el') DO (
    wevtutil cl "%%G"
)
exit
