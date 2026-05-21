import "@typespec/http";
import "@typespec/openapi";
import "./models/core.tsp";
import "./models/requests.tsp";
import "./models/responses.tsp";
import "../../types";
import "../tags.tsp";
import "../../../_shared/alias/token-permissions.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Types.StatusCodes;

@route("/addresses")
namespace RelayRestAPI.Addresses {
  @tag(ADDRESSES_TAG)
  @friendlyName("Addresses")
  interface Addresses {
    @operationId("list_addresses")
    @summary("List all Addresses.")
    @doc("""
      Returns a list of your Addresses. The addresses are returned sorted by creation date, with the most recent appearing first.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    list(...ListAddressesQuery):
      | AddressListResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("create_address")
    @summary("Create an address")
    @doc("""
      To create a new Address, make a POST request to the Address resource.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @post
    create(@body body: CreateAddressRequest):
      | {
          @statusCode statusCode: 201;
          @body address: AddressResponse;
        }
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("get_address")
    @summary("Retrieve an Address")
    @doc("""
      Retrieves the details of an Address that has been previously created.
      Use the unique ID that was returned from your previous request to identify the specific instance.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    read(...AddressPathID):
      | AddressResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("delete_address")
    @summary("Delete an Address")
    @doc("""
      Permanently deletes an Address. It cannot be undone.
      
      ${tokenPermissions<"_Numbers_">}
      """)
    @delete
    delete(...AddressPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
