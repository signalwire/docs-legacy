import "../../_shared/enums.tsp";

model PhoneRouteAssignRequest {
  @doc("The id of the phone route.")
  @example("691af061-cd86-4893-a605-173f47afc4c2")
  @format("uuid")
  phone_route_id: uuid;

  @doc("Indicates if the resource should be assigned to a `calling` or `messaging` handler.")
  @example(UsedForType.Calling)
  handler: UsedForType;
}
