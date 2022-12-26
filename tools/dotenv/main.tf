variable "filepath" {
  type = string
}

output "result" {
  value = { for tuple in regexall("(.*)=(.*)", file(var.filepath)) : tuple[0] => replace(tuple[1], "\"", "") }
}
