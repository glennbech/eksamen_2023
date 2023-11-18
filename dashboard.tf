resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.kandidat
  dashboard_body = <<THEREBEDRAGONS
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "${var.kandidat}",
            "account_count.value"
          ]
        ],
        "period": 300,
        "stat": "Maximum",
        "region": "eu-west-1",
        "title": "Some thing"
      }
    }
  ]
}
THEREBEDRAGONS
}
