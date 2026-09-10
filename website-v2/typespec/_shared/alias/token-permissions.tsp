/**
 * Reusable token permissions description template.
 * Use this alias in @doc decorators to maintain consistent permission documentation.
 *
 * @example Single scope
 * ```typespec
 * import "../../_shared/alias/token-permissions.tsp";
 *
 * @doc("""
 * Operation description here.
 *
 * ${tokenPermissions<"_Voice_">}
 * """)
 * ```
 *
 * @example Multiple scopes
 * ```typespec
 * ${tokenPermissions<"_Voice_, _Messaging_, _Fax_, or _Video_">}
 * ```
 */
alias tokenPermissions<Scopes extends string> = """
  #### Permissions
  
  The API token used to authenticate must have the following scope(s) enabled to make a successful request: ${Scopes}.
  
  [Learn more about API scopes](/docs/platform/your-signalwire-api-space).
  """;
