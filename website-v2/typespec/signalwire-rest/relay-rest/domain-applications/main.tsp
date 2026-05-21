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

@route("/domain_applications")
namespace RelayRestAPI.DomainApplications {
  @tag(DOMAIN_APPLICATIONS_TAG)
  @friendlyName("Domain Applications")
  interface DomainApplications {
    @operationId("list_domain_applications")
    @summary("List all Domain Applications")
    @doc("""
      Returns a list of your domain applications. The domain applications are returned sorted by creation date, with the most recent domain applications appearing first.
      
      ${tokenPermissions<"_Voice_, _Messaging_, or _Fax_">}
      """)
    list(...ListDomainApplicationsQuery):
      | DomainApplicationListResponse
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("create_domain_application")
    @summary("Create a Domain Application")
    @doc("""
      Creates a new domain application.
      
      ${tokenPermissions<"_Voice_, _Messaging_, or _Fax_">}
      """)
    @post
    create(@body body: CreateDomainApplicationRequest):
      | {
          @statusCode statusCode: 201;
          @body domain_application: DomainApplicationResponse;
        }
      | StatusCode401
      | ValidationError
      | StatusCode500;

    @operationId("retrieve_domain_application")
    @summary("Retrieve a Domain Application")
    @doc("""
      Retrieves the details of a Domain Application that has been previously created.
      
      ${tokenPermissions<"_Voice_, _Messaging_, or _Fax_">}
      """)
    read(...DomainApplicationPathID):
      | DomainApplicationResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("update_domain_application")
    @summary("Update a Domain Application")
    @doc("""
      Updates a Domain Application.
      
      ${tokenPermissions<"_Voice_, _Messaging_, or _Fax_">}
      """)
    @put
    update(
      ...DomainApplicationPathID,
      @body body: UpdateDomainApplicationRequest,
    ):
      | DomainApplicationResponse
      | StatusCode401
      | StatusCode404
      | ValidationError
      | StatusCode500;

    @operationId("delete_domain_application")
    @summary("Delete a Domain Application")
    @doc("""
      Permanently deletes a Domain Application. It cannot be undone.
      
      ${tokenPermissions<"_Voice_, _Messaging_, or _Fax_">}
      """)
    @delete
    delete(...DomainApplicationPathID):
      | {
          @statusCode statusCode: 204;
        }
      | StatusCode400
      | StatusCode401
      | StatusCode404
      | StatusCode500;
  }
}
