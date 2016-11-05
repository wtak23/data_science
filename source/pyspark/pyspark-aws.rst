PySpark on AWS (``pyspark-aws``)
""""""""""""""""""""""""""""""""
.. note:: Databricks is nice, but I also wanted to get my hands wet on configuring my own AWS S3, EC2, EMR setup, as well as have a local installation of PySpark working. So here I noted down the steps I took to have my own Spark application running on AWS.

.. contents:: `Contents`
   :depth: 2
   :local:


http://spark.apache.org/downloads.html

##########################
Setting up AWS and PySpark
##########################
.. code-block:: bash

    $ pip install awscli --user
    Collecting awscli
      Downloading awscli-1.10.66-py2.py3-none-any.whl (1.0MB)
        100% |████████████████████████████████| 1.0MB 1.2MB/s 
    Requirement already satisfied (use --upgrade to upgrade): docutils>=0.10 in /home/takanori/anaconda2/lib/python2.7/site-packages (from awscli)
    Requirement already satisfied (use --upgrade to upgrade): rsa<=3.5.0,>=3.1.2 in /home/takanori/.local/lib/python2.7/site-packages (from awscli)
    Collecting s3transfer<0.2.0,>=0.1.0 (from awscli)
      Downloading s3transfer-0.1.4-py2.py3-none-any.whl (52kB)
        100% |████████████████████████████████| 61kB 4.6MB/s 
    Collecting botocore==1.4.56 (from awscli)
      Downloading botocore-1.4.56-py2.py3-none-any.whl (2.6MB)
        100% |████████████████████████████████| 2.6MB 592kB/s 
    Requirement already satisfied (use --upgrade to upgrade): colorama<=0.3.7,>=0.2.5 in /home/takanori/anaconda2/lib/python2.7/site-packages (from awscli)
    Requirement already satisfied (use --upgrade to upgrade): pyasn1>=0.1.3 in /home/takanori/anaconda2/lib/python2.7/site-packages (from rsa<=3.5.0,>=3.1.2->awscli)
    Requirement already satisfied (use --upgrade to upgrade): futures<4.0.0,>=2.2.0; python_version == "2.6" or python_version == "2.7" in /home/takanori/.local/lib/python2.7/site-packages (from s3transfer<0.2.0,>=0.1.0->awscli)
    Requirement already satisfied (use --upgrade to upgrade): python-dateutil<3.0.0,>=2.1 in /home/takanori/.local/lib/python2.7/site-packages (from botocore==1.4.56->awscli)
    Collecting jmespath<1.0.0,>=0.7.1 (from botocore==1.4.56->awscli)
      Downloading jmespath-0.9.0-py2.py3-none-any.whl
    Requirement already satisfied (use --upgrade to upgrade): six>=1.5 in /home/takanori/.local/lib/python2.7/site-packages (from python-dateutil<3.0.0,>=2.1->botocore==1.4.56->awscli)
    Installing collected packages: jmespath, botocore, s3transfer, awscli
    Successfully installed awscli-1.10.66 botocore-1.4.56 jmespath-0.9.0 s3transfer-0.1.4

*******************
Create IAM user key
*******************
.. important:: 

  Do **NOT** create ROOT access-key. Dangerous!

  - http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
  - http://docs.aws.amazon.com/general/latest/gr/root-vs-iam.html

With IAM, you can securely control access to AWS services and resources for users in your AWS account. For example, if you require administrator-level permissions, you can create an IAM user, grant that user full access, and then use those credentials to interact with AWS. If you need to modify or revoke your permissions, you can delete or modify the policies that are associated with that IAM user.

***************************
Create admin group and user
***************************
.. admonition:: References
    
    - http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html
    - http://mollyrossow.com/how%20to/2015/08/04/How-to-run-PySpark-on-AWS-EMR%20and-S3/

.. important::

    For aws cli reference, see http://docs.aws.amazon.com/cli/latest/reference/index.html


- Below is after I created a user with access-key (saved info in ``~/awsinfo``, a safe path in my local computer).
- For user info, go to https://console.aws.amazon.com/iam/home#home


.. code-block:: bash

    # enter user access-key info I just created
    $ aws configure
    AWS Access Key ID [None]: --
    AWS Secret Access Key [None]: --
    Default region name [None]: us-east-1
    Default output format [None]: 

    # confirm the group was created
    $ aws iam list-groups
    {
        "Groups": [
            {
                "Path": "/", 
                "CreateDate": "2016-09-23T17:10:54Z", 
                "GroupId": "--", 
                "Arn": "arn:aws:iam::--:group/admin", 
                "GroupName": "admin"
            }
        ]
    }

    # confirm policy is attached to the group with AdministratorAccess
    $ aws iam list-attached-group-policies --group-name admin
    {
        "AttachedPolicies": [
            {
                "PolicyName": "AdministratorAccess", 
                "PolicyArn": "arn:aws:iam::aws:policy/AdministratorAccess"
            }
        ]
    }

******************
Setup an S3 Bucket
******************
http://mollyrossow.com/how%20to/2015/08/04/How-to-run-PySpark-on-AWS-EMR%20and-S3/

https://console.aws.amazon.com/s3/home

Below I set a bucket called ``pyspark-test-sep23``

.. image:: /_static/img/S3_pyspark_test.png
    :align: center
    :scale: 100 %

You can upload data to the bucket from aws cli:

.. code-block:: bash
    
    $ echo "hello aws" > ~/test.txt
    $ aws s3 cp ~/test.txt s3://pyspark-test-sep23
    upload: ../test.txt to s3://pyspark-test-sep23/test.txt
    $ aws s3 cp ~/data.txt s3://pyspark-test-sep23
    upload: ../data.txt to s3://pyspark-test-sep23/data.txt

*********************************
Create wordcount script to submit
*********************************
.. literalinclude:: SimpleApp.py
    :language: python

******************
Create EMR cluster
******************
.. image:: /_static/img/pyspark-test-emr.png
    :align: center
    :scale: 100 %

.. image:: /_static/img/pyspark-test-emr2.png
    :align: center
    :scale: 100 %

****************************
Run Spark application on EMR
****************************
.. image:: /_static/img/pyspark-test-emr3.png
    :align: center
    :scale: 100 %

.. code-block:: bash

    # unset my variables that configures PYSPARK to run on Jupyter
    $ unset PYSPARK_DRIVER
    $ unset PYSPARK_DRIVER_PYTHON_OPTS 

    # grrr...sc.textFile is raising error on URI location...couldn't figure this out...
    $ spark-submit --packages org.apache.hadoop:hadoop-aws:2.7.1 --master spark:://<Master public DNS> SimpleApp.py 2>&1 | tee pyspark-test-log-0923.log

    # i hard-coded the text variable in my above script for the sake of running something on erm
    $ spark-submit --packages org.apache.hadoop:hadoop-aws:2.7.1 --master \
        spark:://ec2-54-166-62-109.compute-1.amazonaws.com SimpleApp.py \
        1> emr_test.stdout 2>emr_test.stderr

Output:

.. literalinclude:: emr_test.stdout

The complaint/exception I get is: ``java.lang.IllegalArgumentException: Invalid hostname in URI``

This is odd, since the path i gave workedin ``boto``...maybe I screwed one of the config up in AWS management console...



################################
Setup pyspark in ipython profile
################################
.. admonition:: References

   - http://www.cloudera.com/documentation/enterprise/latest/topics/spark_ipython.html
   - http://www.cloudera.com/documentation/enterprise/latest/topics/spark_ipython.html#ipython__jupyter_install
   - http://blog.cloudera.com/blog/2014/08/how-to-use-ipython-notebook-with-apache-spark/
   - https://plot.ly/python/apache-spark/
   - http://ipython.readthedocs.io/en/stable/development/config.html

***************
Finally worked!
***************
.. admonition:: Timestamp
   
   23 September 2016 (Friday)

Got the setup from comment by **Wanderer** from http://thepowerofdata.io/configuring-jupyteripython-notebook-to-work-with-pyspark-1-4-0/


Included these in my ``.bashrc`` file

.. code-block:: bash

    export SPARK_HOME=$HOME/mybin/spark-2.0.0-bin-hadoop2.7
    export PATH="$SPARK_HOME:$PATH"
    export PATH=$PATH:$SPARK_HOME/bin
    
    export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
    # export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH

    export ANACONDA_ROOT=~/anaconda2
    export PYSPARK_DRIVER_PYTHON=$ANACONDA_ROOT/bin/jupyter
    export PYSPARK_DRIVER_PYTHON_OPTS='notebook' pyspark
    export PYSPARK_PYTHON=$ANACONDA_ROOT/bin/python

Now I can invoke pyspark in jupyter as default via calling ``$pyspark``

.. important:: 

    However, to submit job application via ``spark-submit``, need to comment
    out these variables:

    .. code-block:: bash
    
        #export PYSPARK_DRIVER_PYTHON=$ANACONDA_ROOT/bin/jupyter
        #export PYSPARK_DRIVER_PYTHON_OPTS='notebook' pyspark

    When submitting, just ``unset`` these variables from the commandline.

    .. code-block:: bash
    
        unset PYSPARK_DRIVER_PYTHON
        unset PYSPARK_DRIVER_PYTHON_OPTS
        spark-submit ${SPARK_HOME}/examples/src/main/python/pi.py

*******************
Wrong java version?
*******************

https://community.cloudera.com/t5/Storage-Random-Access-HDFS/Failed-to-load-native-hadoop-with-error-libhadoop-so-1-0-0-wrong/td-p/31573

.. code-block:: bash

    $ java -version
    java version "1.7.0_79"
    OpenJDK Runtime Environment (IcedTea 2.5.6) (7u79-2.5.6-0ubuntu1.14.04.1)
    OpenJDK 64-Bit Server VM (build 24.79-b02, mixed mode)

.. rubric:: Installing java8...harder than i thought

Following this thread achieved my goal (http://stackoverflow.com/questions/32942023/ubuntu-openjdk-8-unable-to-locate-package?rq=1)

.. code-block:: bash

    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer

.. code-block:: bash

    $ java -version
    java version "1.8.0_101"
    Java(TM) SE Runtime Environment (build 1.8.0_101-b13)
    Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)

********************************
pyspark options giving errors...
********************************
.. code-block:: bash

    $ pyspark options
    Exception in thread "main" java.lang.IllegalArgumentException: pyspark does not support any application options.
        at org.apache.spark.launcher.CommandBuilderUtils.checkArgument(CommandBuilderUtils.java:241)
        at org.apache.spark.launcher.SparkSubmitCommandBuilder.buildPySparkShellCommand(SparkSubmitCommandBuilder.java:290)
        at org.apache.spark.launcher.SparkSubmitCommandBuilder.buildCommand(SparkSubmitCommandBuilder.java:147)
        at org.apache.spark.launcher.Main.main(Main.java:86)

*************
Update scala?
*************
http://spark.apache.org/docs/latest/

  Spark runs on Java 7+, Python 2.6+/3.4+ and R 3.1+. For the Scala API, Spark 2.0.0 uses Scala 2.11. You will need to use a compatible **Scala version (2.11.x)**.

.. code-block:: bash

    $ scala -version
    Scala code runner version 2.9.2 -- Copyright 2002-2011, LAMP/EPFL

http://www.scala-lang.org/download/2.11.8.html

in bashrc:

.. code-block:: bash

    export PATH="/home/takanori/mybin/scala-2.11.8/bin:$PATH"
    $ scala -version
    Scala code runner version 2.11.8 -- Copyright 2002-2016, LAMP/EPFL


************
rough drafts
************
Added these to my ``.bashrc`` file:

.. code-block:: bash

    export SPARK_HOME=$HOME/mybin/spark-2.0.0-bin-hadoop2.7
    # http://www.cloudera.com/documentation/enterprise/latest/topics/spark_ipython.html#ipython__jupyter_install
    export PYSPARK_DRIVER=$HOME/anaconda2/bin/jupyter
    export PYSPARK_DRIVER_PYTHON_OPTS="notebook --NotebookApp.open_browser=False --NotebookApp.ip='*' --NotebookApp.port=8880"
    export PYSPARK_PYTHON=$HOME/anaconda2/bin/python




.. code-block:: bash

    $ ipython profile create pyspark
    [ProfileCreate] Generating default config file: u'/home/takanori/.ipython/profile_pyspark/ipython_config.py'
    [ProfileCreate] Generating default config file: u'/home/takanori/.ipython/profile_pyspark/ipython_kernel_config.py'

    $ # i updated by .bashrc to do this
    $ export SPARK_HOME=$HOME/mybin/spark-2.0.0-bin-hadoop2.7

    # this is where you specify all the options you would normally add after bin/pyspark
    export PYSPARK_SUBMIT_ARGS='--master yarn --deploy-mode client --num-executors 24 --executor-memory 10g --executor-cores 5'

.. code-block:: bash
    
    $ ipython profile list

    Available profiles in /home/takanori/.ipython:
        pyspark
        default

    To use any of the above profiles, start IPython with:
        ipython --profile=<name>

##################
Failed Windows Try
##################
.. todo:: Come back to this later...Below didn't pan out...fix later (kept notes for my own reference). 09-23-2016 (12:34)

********
windows?
********
09-05-2016 (15:36)

.. admonition:: References

  - http://www.ithinkcloud.com/tutorials/tutorial-on-how-to-install-apache-spark-on-windows/
  - http://jmdvinodjmd.blogspot.com/2015/08/installing-ipython-notebook-with-apache.html    


#. Download tgz from http://spark.apache.org/downloads.html  
#. Unzip the folder ``spark-2.0.0-bin-hadoop2.7`` under ``C:\spark-2.0.0-bin-hadoop2.7``
#. Set env-var by:

  - Start Menu -> My Computer (Right Click and select ``Properties``) -> Advanced System Settings (see screenshot)
  - Create an Environment variable named ``SPARK_HOME`` with value equal to ``C:\spark-2.0.0-bin-hadoop2.7``


.. important::

  - http://stackoverflow.com/questions/31962862/ipython-ipython-notebook-config-py-missing

  ``ipython_notebook_config.py`` no longer around after ``jupyter``, so above instruction no longer applies...

  Do this to create jupyter profile under ``~/.jupyter``
  
  .. code-block:: bash
  
      $ jupyter notebook --generate-config
      Writing default config to: C:\Users\takanori\.jupyter\jupyter_notebook_config.py

  For more info, see:

  - http://jupyter.readthedocs.io/en/latest/migrating.html
  - http://jupyter.readthedocs.io/en/latest/migrating.html#profiles

.. image:: /_static/img/pyspark_install_win_pic1.png
   :align: center

.. image:: /_static/img/pyspark_install_win_pic2.png
   :align: center


**************************
Retry, above is a disaster
**************************
http://stackoverflow.com/questions/32948743/cant-start-apache-spark-on-windows-using-cygwin

http://spark.apache.org/docs/latest/spark-standalone.html

http://stackoverflow.com/questions/17465581/how-to-set-up-spark-cluster-on-windows-machines

I first need java: 

- https://www.java.com/en/download/faq/win10_faq.xml
- https://www.java.com/en/download/help/windows_manual_download.xml

Else i got the message:

.. code-block:: bash
    
    takanori@DESKTOP-FJQ41I1 /home/takanori
    $ pyspark
    Error: Could not find or load main class org.apache.spark.launcher.Main

    takanori@DESKTOP-FJQ41I1 /home/takanori
    $ which pyspark
    /home/takanori/\spark-2.0.0-bin-hadoop2.7\bin/pyspark

.. admonition:: ...maybe cygwin isn't the way to go...

  http://stackoverflow.com/questions/34483855/installing-spark-for-python-through-cgwin

  See comment by Josh Rosen, one of PySpark's original authors.

    As one of PySpark's original authors, I do not recommend using it in Cygwin.