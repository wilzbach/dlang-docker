FROM dlang2/dmd-ubuntu
WORKDIR /dlang/app
COPY . .

RUN dub build -v
CMD ["/dlang/app/app"]
