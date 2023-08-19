# Extend from the official Elixir image
FROM elixir:latest

RUN mix local.hex --force \
    && mix archive.install --force hex phx_new \
    && apt-get update \
    && curl -sL https://deb.nodesource.com/setup_lts.x | bash \
    && apt-get install -y apt-utils \
    && apt-get install -y nodejs \
    && apt-get install -y build-essential \
    && apt-get install -y inotify-tools \
    && mix local.rebar --force

ENV APP_HOME /phoenix_app
RUN mkdir -p $APP_HOME
COPY . /phoenix_app
WORKDIR $APP_HOME


# Update the package list and install wget
RUN apt-get update && apt-get install -y wget

# Descargar el archivo
#RUN wget https://github.com/tailwindlabs/tailwindcss/releases/download/v3.3.2/tailwindcss-linux-x64

# Copia el archivo descargado a la ubicación deseada en el contenedor
#COPY tailwindcss-linux-x64 /phoenix_app/_build/tailwind-linux-x64

EXPOSE 4000
EXPOSE 443
# Netcat install
RUN apt-get update && apt-get install -y netcat

#Esto actualizará los certificados de confianza utilizados por Hex y Erlang.
RUN mix deps.update castore
# Descargar esbuild
RUN npm install -g esbuild

# Install wait-for script (a simple script to wait for a service to be available)
RUN curl -o /usr/local/bin/wait-for -sSL https://raw.githubusercontent.com/eficode/wait-for/master/wait-for \
    && chmod +x /usr/local/bin/wait-for

# Wait for the database to be available before starting the Phoenix app
CMD ["wait-for", "db:5432", "--", "mix", "phx.server"]