file(GLOB files "${from}/*")
file(COPY ${files} DESTINATION "${to}")