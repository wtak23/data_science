"""SimpleApp.py"""
from pyspark import SparkContext
import os

# Get access key info in setted up on AWS management console
with open( os.path.expanduser('~/awsinfo/access-key-id'), 'r') as f:
    access_key = f.read()
with open( os.path.expanduser('~/awsinfo/secret-access-key'), 'r') as f:
    secret_key = f.read()

bucket = 'pyspark-test-sep23'
# bucket = 'sparktak'
# dataFile = "/data.txt"  # Should be some file on your system
dataFile = "s3n://{ACCESS_KEY}:{SECRET_KEY}@{BUCKET_NAME}/data.txt".format(
            ACCESS_KEY=access_key, SECRET_KEY=secret_key, BUCKET_NAME=bucket)

# print "dataFile = ",dataFile

sc = SparkContext("local", "Simple App")
# logData = sc.textFile(dataFile).cache() # <- somehow gives an error...see https://github.com/databricks/spark-redshift/issues/135 (could be related)
text_info = """
I am takanori. I am takanori.
Lerem ipsum.
This is not the idea way to do it.
Some how sending s3 to sc.text raises an error.
So just directly feed in a text variable to sc parallelize to create RDD.
Need to figure this out later.
"""
# print text_info
logData = sc.parallelize(text_info)

numAs = logData.filter(lambda s: 'a' in s).count()
numBs = logData.filter(lambda s: 'b' in s).count()

print "Lines with a: %i, lines with b: %i" % (numAs, numBs)