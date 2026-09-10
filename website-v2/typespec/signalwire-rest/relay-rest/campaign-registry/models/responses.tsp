import "./core.tsp";
import "../../addresses/models/responses.tsp";

using TypeSpec.Http;

@doc("Response containing a list of brands.")
model BrandListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of brands.")
  data?: Brand[];
}

@doc("Response containing a single brand.")
model BrandResponse {
  ...Brand;
}

@doc("Response containing a list of campaigns.")
model CampaignListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of campaigns.")
  data?: Campaign[];
}

@doc("Response containing a single campaign.")
model CampaignResponse {
  ...Campaign;
}

@doc("Response containing a list of assigned numbers.")
model AssignedNumberListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of assigned numbers.")
  data?: AssignedNumber[];
}

@doc("Response containing a single assigned number.")
model AssignedNumberResponse {
  ...AssignedNumber;
}

@doc("Response containing a list of orders.")
model OrderListResponse {
  @doc("Pagination links.")
  links?: PaginationLinks;

  @doc("List of orders.")
  data?: Order[];
}

@doc("Response containing a single order.")
model OrderResponse {
  ...Order;
}
