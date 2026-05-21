import "../../../../types";

model SubscriberToken {
  @doc("The ID of the subscriber that the token is associated with.")
  @example("32d94154-9297-418c-9a85-4a69e0c67c30")
  @format("uuid")
  subscriber_id: uuid;

  @doc("The token that is associated with the subscriber.")
  @format("jwt")
  @example("eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwidHlwIjoiU0FUIn0..HahMYxqt4uI14qSH.daMTBR53lfEfEFiVAhr0pPSRqZhEod_YzavoG9-4ieiRQvl8GtP3FFNx0VLfkJqNcjUNbAaiKrEMnfOtCnQjiq1Kn0Iq90MYdM00QJ7cTaQ88vfbqdE92p-d4oDeg6z_vAsgrFgEobmrlDQndKxCWOD921iYxyLP0vqNaokN3kIM06iAWu_UpnTYEeR1l068xhK2xb6P9wbI2FDKFQoMgCdbjvABF7RRyaEzUoaQ5_Wj53YO6PFYuYcPbqMhdtvSSQiK3Nw6bFer2OfFs6s2RTukRGsocgC5Q7pwQwzYky-YgrPCb-pVAJajVSXUJrayvOi8-TeyCpICW4zTeJa5icZ380cWtafUH4rEB_FOJciJf0BCy48ajbz0NE121uBl2mqA1HE0_mQA53UqVjbrbE9hVOfnN4KpwOfULhIjx54tIekJQgG-aK2AYsLPCDNhuSpHvdwJcTM0Gzy3mS2veyaDV8q2qN5F_F9OThTQzcfy.AXzVNrJc_pGVPsticsVM0w")
  token: jwt;

  @doc("Refresh token.")
  @format("jwt")
  @example("eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwidHlwIjoiUmVmcmVzaCIsImNoIjoidGVzdHB1Yy5zaWduYWx3aXJlLmNvbSJ9..sHcQL_V1tZH2JEAh.FNKYe_49CazNthkgSphf-ov8_I2wGLGWKD6t2q7kiG0guBxBjGzpgD8Y-LM-Nu7ePRUg7Z6vBkKAvh3rjtZpkeXoRXobJ1lov9AO72l8tB9K9RLo-TnBxLDbh0BCDGWVBgGq8DOh9kzHz4Tot-_B8pHXY_bqXX5kC4UUszXCO9nhSi1a4rp6QMD_8b0Mm8pHDK9EtW8I-tfM0HPmXuPMuOnlft3hmZo3tiKN2CarWscveQPCGetufHfQJJssdHjjYup8USAX0gJM8dpsV7FpF9fxfpy4ZU7N9MJXgSYJM5cPrxpLLx3Lj291egob14jDkn7kZQpv7jbCtsGyYxC7HAi1FgGr_sw3AeGaf2esGCkaeE11MxL05_kwdiNYBSOaHqaY62kOzu5pIdfTKQekOogCS1fgiyBgisBZeSIEBWWF.neE9KnL5AzS165dXFXUqhQ")
  refresh_token: jwt;
}
