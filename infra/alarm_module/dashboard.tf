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
            "violation_count.value"
          ]
        ],
        "period": 300,
        "stat": "Maximum",
        "region": "eu-west-1",
        "title": "Number of violations"
      }
    },
      {
      "type": "metric",
      "x": 5,
      "y": 10,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "${var.kandidat}",
            "person_count.value"
          ]
        ],
        "period": 300,
        "stat": "Maximum",
        "region": "eu-west-1",
        "title": "Number of people checked"
      }
    },
      {
      "type": "metric",
      "x": 10,
      "y": 20,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "${var.kandidat}",
            "scan_count.value"
          ]
        ],
        "period": 300,
        "stat": "Maximum",
        "region": "eu-west-1",
        "title": "Number of images scanned"
      }
  ]
}
THEREBEDRAGONS
}
