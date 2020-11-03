DESTDIR = ~/Desktop/FILM


all:
	rm -f FILM.js
	cat *.js > tmp.txt
	cat Constants tmp.txt > FILM.js
	rm tmp.txt
	mkdir -p ${DESTDIR}
	cp FILM.js ${DESTDIR}
	cp map.png ${DESTDIR}
	cp teapot.obj ${DESTDIR}
	cp teapot.mtl ${DESTDIR}
	cp scrollingtext.txt ${DESTDIR}
