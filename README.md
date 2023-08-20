# Assignment01

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Docker

In order to run docker you will need to do:

1. docker compose up
2. Una vez que docker compose up termina se debe de correr este comando: docker-compose run web mix ecto.create para crear la base de datos.
3. Y luego docker-compose run web mix ecto.migrate.
4. Terminar el docker compose up.
5. Recorrer el docker compose up para que vuelva funcionar sin errores.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
