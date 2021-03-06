% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-def.R
\docType{class}
\name{flow-class}
\alias{flow}
\alias{flow-class}
\title{Describing the flow class}
\usage{
flow(jobs = list(new("job")), name = "newflow", desc = "my_super_flow",
  mode = c("scheduler", "local"),
  flow_run_path = opts_flow$get("flow_run_path"), trigger_path = "",
  flow_path = "", version = "0.0", status = "created",
  module_cmds = opts_flow$get("module_cmds"), execute = "")
}
\arguments{
\item{jobs}{\code{list}: A list of jobs to be included in this flow}

\item{name}{\code{character}: Name of the flow. ['newflow']}

\item{desc}{\code{character} Description of the flow, used to uniquely identify a 
flow instance. ['my_super_flow']}

\item{mode}{\code{character} Mode of submission of the flow (depreciated). ['scheduler']}

\item{flow_run_path}{The base path of all the flows you would submit. [~/flows]}

\item{trigger_path}{\code{character} [\code{~/flows/trigger}].}

\item{flow_path}{\code{character}: A unique path identifying a flow instance, populated by \link{submit_flow}.}

\item{version}{version of flowr used to create and execute this flow.}

\item{status}{\code{character}: Status of the flow.}

\item{module_cmds}{[advanced use] a character vector of cmds which will be pre-pended to all script of this pipeline. 
Could be cmds like \code{`module load mytool1;module load mytool2`}}

\item{execute}{executtion status of flow object. [FALSE]}
}
\description{
Internal function (used by \link{to_flow}), which aids in creating a flow object.
}
\examples{
cmds = rep("sleep 5", 10)
qobj <- queue(platform='torque')
## run the 10 commands in parallel
jobj1 <- job(q_obj=qobj, cmd = cmds, submission_type = "scatter", name = "job1")

## run the 10 commands sequentially, but WAIT for the previous job to complete
## Many-To-One
jobj2 <- job(q_obj=qobj, cmd = cmds, submission_type = "serial",
 dependency_type = "gather", previous_job = "job1", name = "job2")

## As soon as first job on 'job1' is complete
## One-To-One
jobj3 <- job(q_obj=qobj, cmd = cmds, submission_type = "scatter",
 dependency_type = "serial", previous_job = "job1", name = "job3")

fobj <- flow(jobs = list(jobj1, jobj2, jobj3))

## plot the flow
plot_flow(fobj)
\dontrun{
## dry run, only create the structure without submitting jobs
submit_flow(fobj)

## execute the jobs: ONLY works on computing cluster, would fail otherwise
submit_flow(fobj, execute = TRUE)
}
}

