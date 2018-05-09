# EBS Optimized AMIs sparkle pack

A [SparkleFormation]() registry to dynamically fetch the latest ECS optimized
AMIs in all supported regions.

This can be slow since it has to make a separate client connection for each
supported region.
