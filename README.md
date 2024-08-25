# README

This project is to develop a basic recommendation engine for a job-matching platform. The goal of the engine is to suggest jobs to jobseekers based on their skills and the required skills for each job.

this project would accept 2 csv files, one for jobs and another for job seekers.

### Running
to access the app run `rails s`. You can access the app by visiting `localhost:3000` in your browser. 

### Runthrough

when you first visit the app, it would drop you off at the root page.
![Root Page](./lib/images/root_page.png)

To upload job from the csv you need to do it in the job csv upload part of the page where you put the file in and click on the "Upload Jobs".
![Job Upload](./lib/images/job_upload.png)

once it's uploaded you can click on the "Job List" button where it would bring you to the job list page.
![Job List](./lib/images/job_list_page.png)

You would do the same for job seekers upload.
![Job Seeker Upload](./lib/images/job_seeker_upload.png)

you can view the job seeker lists when you click on the "Job Seeker List"
![Job Seeker List](./lib/images/job_seeker_list_page.png)

once you uploaded both the jobs and jobseeker csv, when you are back in the root page, it would automatically generate the table for the job matching.
![Root Page With Data](./lib/images/root_page_data.png)

### Tests
Run `bundle exec rspec` to run the tests