#Using add_index in your migrations#

I had been working on a project lately that involved a huge lot of table and migrations. I thought I was doing well with the tables using associations and all and thought the system to work well. But when I ported the application to production mode from the development mode, things began to slow down. I was curious on what was slowing down my app. So I decided to dig deep into the logs.

###What was missing?###
<br>
A deeper analysis on the logs gave me a clear idea on my mistake. I could find that the queries, esp the select querues, are taking a lot of time to get executed.

###Understanding the Problem###
<br>
My application had a Users table which have more than 10K registered  and active users in that. And I had a search function using which I used the First Name of users for searching a user.

`@user = User.where(first_name:"Manu")`

What this basically does is a searching. It would search the users table for users having first_name as "Manu". If the user who you are searching is at the bottom of the table then you are in great trouble.

###Solution to the Problem - Indexing###
<br>
The best solution for this problem, was to avoid the searching and directly select the user from the table. for this I had to  add index to my table.
So I wrote a migration to add the same
```
def self.up
  add_index :users, :first_name
end

def self.down
  remove_index :users, :first_name
end
```
Now instead of searching the users it will use the index to select the user from the table.

At this point you would be probably thinking of adding index to all the fields in your table and making your search queries lightning fast. But there is always two sides of a coin. As adding index to your tables makes your search queries faster, on the other side it will make the insertion and updation slower. As every time a record is inserted or modified the index needs to be updated.
<br>
Considering the insertion is one time and updation is done less often, I would prefer to add index for the fields on my table.

###Demo App###
<br>
I have made a demo app to demonstrate the same. The `home_controller.rb` has a search action using which the users can be searched by their first name.
Before adding the index to the database searching a user among 10,000 users took about 18.2ms. But this dropped to 0.4ms on adding index to the first name.

If you want to try out the app using rails console then,

```
#enter the rails console
rails c

#perform a search query to search a user with first name "user10000"
user = User.where('first_name = ?', "user10000").first.first_name
```

--
<br>
Manu S Ajith
<br>
[@manusajith](http://twitter.com/manusajith "@manusajith") | [github](http://github.com/manusajith "@manusajith")