# utaq

## Usage

1. Edit cf.yml and add your browser's IP for ports 80 and 8080.
2. Run the launch script. It takes a single command line parameter, the name of your new stack.
3. Read the comments at the tail of `userdata/utap-rds/install`,
4. In the AWS RDS console, manually make the two RDS security group changes mentioned in #2. (This will be automated someday.)
5. Access UTAP at http://w.x.y.z
