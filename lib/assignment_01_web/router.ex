defmodule Assignment01Web.Router do
  use Assignment01Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Assignment01Web.Layouts, :root}
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Assignment01Web do
    pipe_through :browser
    resources "/authors", AuthorController
    resources "/books", BookController
    resources "/sales", SaleController
    resources "/reviews", ReviewController
    resources "/model_statistic", ModelStatisticController, only: [:index]
    get "/", PageController, :home
  end

  scope "/books", Assignment01Web do
    pipe_through :browser
    post "/books_search_by_description", BookController, :books_search_by_description
  end

  scope "/model_statistic", Assignment01Web do
    pipe_through :browser
    get "/statistics_01", ModelStatisticController, :statistics_01
    post "/statistics_01_post", ModelStatisticController, :statistics_01_post, csrf: false
    get "/top_50_selling_books", ModelStatisticController, :top_50_selling_books
    get "/top_10_rated_books", ModelStatisticController, :top_10_rated_books
  end
  # Other scopes may use custom stacks.
  # scope "/api", Assignment01Web do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:assignment_01, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Assignment01Web.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
