model PubSubToken {
  @doc("A PubSub Token to be used to authenticate clients to the PubSub Service.")
  @example("eyJ0eXAiOiJWUlQiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE2MjIxMjAxMjMsI...wMCwicnNlIjo5MDB9-BqG-DqC5LhpsdMWEFjhVkTBpQ")
  token: string;
}
