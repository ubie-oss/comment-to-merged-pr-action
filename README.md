# comment-to-merged-pr-action
A composite GitHub Action to comment to the merged pull request.

## Inputs
Please look into [action.yml](action.yml) to see the inputs.

- `github-token`: The GitHub token to access the GitHub API.
- `message`: The comment to the merged pull request.

## Outputs
- `pull-request-number`: The number of the pull request.
- `pull-request-creator`: The creator of the pull request.

## Use cases

### Comment to the merged pull request if all jobs are passed
The examples show how to comment to the merged pull request if all jobs are passed.
We assume that the job1 and job2 are the jobs that are executed when the pull request is merged into the default branch.
Those can be something like to deploy a product.

```yaml
name: "Create a comment to the merged pull request"
on:
  push:
    branches:
      - main
jobs:
  comment:
    permissions:
      contents: read
      pull-requests: write
    runs-on: ubuntu-latest
    steps:
      # We have to check out the default branch before using the action.
      - uses: actions/checkout@v3
      # The step is failed.
      - name: "Dummy failed step"
        id: dummy-failed-step
        run: |
          echo "The dummy task was failed."
          exit 1
      # The step is triggered only when dummy-failed-step is failed.
      - uses: ubie-oss/comment-to-merged-pr-action@v0.3.0
        if: ${{ failure() }}
        id: comment-to-merged-pr
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          message: |-
            The dummy task was failed.
            Please take a look at ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }} .
```
