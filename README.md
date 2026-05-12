# SolvePuzzle

## Release candidate builds

Use the **Release Candidate** GitHub Actions workflow to build a signed iOS RC manually. The workflow archives the `Puzzle Pals` scheme, exports an IPA, uploads the IPA and dSYM zip as workflow artifacts, and can optionally create a GitHub prerelease.

Use `app-store-connect` as the export method for TestFlight/App Store signing, or `release-testing` with an Ad Hoc provisioning profile for registered-device testing.

Configure these repository secrets before running it:

- `BUILD_CERTIFICATE_BASE64`: base64-encoded Apple signing certificate `.p12`
- `P12_PASSWORD`: password for the `.p12`
- `PROVISIONING_PROFILE_BASE64`: base64-encoded `.mobileprovision` for `team.runway.puzzlepals`
- `KEYCHAIN_PASSWORD`: optional temporary CI keychain password

On macOS, encode the files with:

```sh
base64 -i Certificates.p12 | pbcopy
base64 -i Profile.mobileprovision | pbcopy
```
