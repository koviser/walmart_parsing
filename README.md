### For starting server run next command
```bash
    bundle install
    bundle exec rake db:migrate
    foreman start -f Procfile.dev
```

### Questions to ask yourself:

### Questions to ask yourself:

1) how do you assure that when you rerun the program for the same product there no duplicates are created? (either in products or reviews)

When I looked at that site I found some value `productID` for each product in redux configures. So as result I used this as identification. If the name or the price have changed productId will be the same. And the similar situation with reviews.

2) Why did you choose a given technology? Do you know any better options? What are the limitations?

I decided to use `rails` because this can be quickly written (because of some limitation in 3 hours). For parsing URL, I used background gem `sidekiq`. Because some parsing working a few seconds. And sidekiq has good feature when with the worker will be some wrong like a network connection or something else. The worker will be retry after some period (maximum 5 times but we can configure that). I  used `webpack` and es6 because this is easier for an understanding of frontend developers, and `npm` has more libraries in front rather then rails gems. And sure I wrote little tests by `rspec`. Because good developer always covers code by tests.

3) Possible problems when scaling up the application.

The biggest problem this is sure that so we parsing another site without API. So we cannot be sure so this code will work tomorrow. And the second problem with reviews parsing. When the count will be nearly 1000_000 than queries with `like` will be to slowly. And we must do for this indexes like `gin` or `gist`. Problems with count and pagination because this will be to slow. So we'll be must optimize our queries for quickly server workers. But all this problem this is big part of discussion)
