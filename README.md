# epita-td

Template for EPITA TD documents.


## Usage

Compile:
```bash
typst compile main.typ
```

Watch (auto-recompile on changes):
```bash
typst watch main.typ
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | str | "Document" | Document title |
| `subtitle` | str/none | none | Optional subtitle |
| `course` | str | "EPITA" | Course or institution name |
| `term` | str/none | none | Academic term (e.g., "S7") |
| `authors` | array | () | List of author names |
| `group` | str/none | none | Group identifier |
| `date` | datetime | today | Document date |
| `logo` | content/str/none | none | Logo image or path |
| `confidentiality` | str/none | none | Confidentiality notice |
| `toc` | bool | false | Show table of contents |
| `lang` | str | "fr" | Document language code |

## Documentation

- [Typst Documentation](https://typst.app/docs/)

## Example

See [exemple/example.pdf](exemple/example.pdf)
