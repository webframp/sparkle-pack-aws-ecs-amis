# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
def supported_regions
  %w[us-east-2 us-east-1
     us-west-2 us-west-1
     eu-west-3 eu-west-2 eu-west-1
     eu-central-1
     ap-northeast-2 ap-northeast-1
     ap-southeast-2 ap-southeast-1
     ca-central-1
     ap-south-1
     sa-east-1]
end

def ecs_optimized_linux_ami(region)
  require 'aws-sdk-core'
  require 'json'
  ssm = ::Aws::SSM::Client.new(region: region)
  result = ssm.get_parameter(name: '/aws/service/ecs/optimized-ami/amazon-linux/recommended')
  metadata = ::JSON.parse(result.data.parameter.value)
  metadata['image_id']
end

# Returns a hash like:
# ami_hash = {"us-east-2": "ami-64300001",
#             "us-east-1": "ami-aff65ad2",
#             "us-west-2": "ami-40ddb938",
#             "us-west-1": "ami-69677709",
#             "eu-west-3": "ami-250eb858",
#             "eu-west-2": "ami-2218f945",
#             "eu-west-1": "ami-2d386654",
#             "eu-central-1": "ami-9fc39c74",
#             "ap-northeast-2": "ami-9d56f9f3",
#             "ap-northeast-1": "ami-a99d8ad5",
#             "ap-southeast-2": "ami-efda148d",
#             "ap-southeast-1": "ami-846144f8",
#             "ca-central-1": "ami-897ff9ed",
#             "ap-south-1": "ami-72edc81d",
#             "sa-east-1": "ami-4a7e2826"
#            }
def amis_to_hash
  h = {}
  supported_regions.each do |region|
    h[region] = ecs_optimized_linux_ami(region)
  end
  h
end

# Get latest
ami_hash = amis_to_hash

SfnRegistry.register(:map_ecs_amis) do
  ami_hash.each do |region, ami|
    mappings do
      ecs_ami_map do
        camel_keys_set!(:auto_disable)
        set!(region).ami ami
      end
    end
  end
end
