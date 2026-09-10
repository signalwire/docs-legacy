import React from "react";

// @ts-ignore
import FormItem from "@theme/ApiExplorer/FormItem";
// @ts-ignore
import FormSelect from "@theme/ApiExplorer/FormSelect";
// @ts-ignore
import FormTextInput from "@theme/ApiExplorer/FormTextInput";
// @ts-ignore
import { useTypedDispatch, useTypedSelector } from "@theme/ApiItem/hooks";


import { setAuthData, setSelectedAuth } from "./slice";

function Authorization() {
  const data = useTypedSelector((state: any) => state.auth.data);
  const options = useTypedSelector((state: any) => state.auth.options);
  const selected = useTypedSelector((state: any) => state.auth.selected);

  const dispatch = useTypedDispatch();

  if (selected === undefined) {
    return null;
  }

  const selectedAuth = options[selected];

  const optionKeys = Object.keys(options);

  return (
    <div>
      {optionKeys.length > 1 && (
        <FormItem label="Security Scheme">
          <FormSelect
            options={optionKeys}
            value={selected}
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
              dispatch(setSelectedAuth(e.target.value));
            }}
          />
        </FormItem>
      )}
      {selectedAuth.map((a: any) => {
        if (a.type === "http" && a.scheme === "bearer") {
          return (
            <FormItem label="Bearer Token" key={a.key + "-bearer"}>
              <FormTextInput
                placeholder="Bearer Token"
                value={data[a.key].token ?? ""}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                  const value = e.target.value;
                  dispatch(
                    setAuthData({
                      scheme: a.key,
                      key: "token",
                      value: value ? value : undefined,
                    })
                  );
                }}
              />
            </FormItem>
          );
        }

        if (a.type === "oauth2") {
          return (
            <FormItem label="Bearer Token" key={a.key + "-oauth2"}>
              <FormTextInput
                placeholder="Bearer Token"
                value={data[a.key].token ?? ""}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                  const value = e.target.value;
                  dispatch(
                    setAuthData({
                      scheme: a.key,
                      key: "token",
                      value: value ? value : undefined,
                    })
                  );
                }}
              />
            </FormItem>
          );
        }

        if (a.type === "http" && a.scheme === "basic") {
          return (
            <React.Fragment key={a.key + "-basic"}>
              <FormItem label="Project ID">
                <FormTextInput
                  placeholder="Project ID"
                  value={data[a.key].username ?? ""}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                    const value = e.target.value;
                    dispatch(
                      setAuthData({
                        scheme: a.key,
                        key: "username",
                        value: value ? value : undefined,
                      })
                    );
                  }}
                />
              </FormItem>
              <FormItem label="API Token">
                <FormTextInput
                  placeholder="API Token"
                  password
                  value={data[a.key].password ?? ""}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                    const value = e.target.value;
                    dispatch(
                      setAuthData({
                        scheme: a.key,
                        key: "password",
                        value: value ? value : undefined,
                      })
                    );
                  }}
                />
              </FormItem>
            </React.Fragment>
          );
        }

        if (a.type === "apiKey") {
          return (
            <FormItem label={`${a.key}`} key={a.key + "-apikey"}>
              <FormTextInput
                placeholder={`${a.key}`}
                value={data[a.key].apiKey ?? ""}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
                  const value = e.target.value;
                  dispatch(
                    setAuthData({
                      scheme: a.key,
                      key: "apiKey",
                      value: value ? value : undefined,
                    })
                  );
                }}
              />
            </FormItem>
          );
        }

        return null;
      })}
    </div>
  );
}

export default Authorization;
