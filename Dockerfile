#Construccion por multiples etapas

#1.- Etapa de construccion
#Nombre de la imagen temporal es "construccion"
FROM rust:latest AS construccion
WORKDIR /app
#Copia de los archivos del proyecto
COPY ./api/src/ ./src/
COPY ./api/Cargo.toml ./api/Cargo.lock ./
#Construir el proyecto
RUN cargo build --release

#2.- Etapa de ejecucion
#Creacion de la imagen final
FROM rust:latest
WORKDIR /app
#Copiar solo el binario resultante de la imagen temporal para img mas ligera.
COPY --from=construccion /app/target/release/api-rust /usr/local/bin/api-rust
CMD ["api-rust"]