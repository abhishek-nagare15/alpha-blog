#!/usr/bin/env bash
set -e

cd "$HOME/Desktop/alpha-blog"

mkdir -p \
  app/views/layouts \
  app/views/pages \
  app/views/articles \
  app/views/users \
  app/views/shared \
  app/assets/stylesheets \
  app/javascript

cat > app/views/layouts/application.html.erb <<'EOF'
<!DOCTYPE html>
<html>
  <head>
    <title>Alpha Blog</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>
  <body class="d-flex flex-column min-vh-100">
    <%= render "layouts/navigation" %>
    <main class="flex-grow-1">
      <%= render "layouts/messages" %>
      <%= yield %>
    </main>
    <%= render "layouts/footer" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
EOF

cat > app/views/layouts/_navigation.html.erb <<'EOF'
<nav class="navbar navbar-expand-lg site-navbar sticky-top">
  <div class="container">
    <%= link_to root_path, class: "navbar-brand brand-logo" do %>
      <span class="brand-mark">A</span><span>Alpha Blog</span>
    <% end %>
    <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
        <li class="nav-item"><%= link_to "Home", root_path, class: "nav-link" %></li>
        <li class="nav-item"><%= link_to "Articles", articles_path, class: "nav-link" %></li>
        <li class="nav-item"><%= link_to "Bloggers", users_path, class: "nav-link" %></li>
        <li class="nav-item"><%= link_to "About", about_path, class: "nav-link" %></li>
        <li class="nav-item ms-lg-2"><%= link_to "Write Article", new_article_path, class: "btn btn-primary nav-action-btn" %></li>
        <li class="nav-item"><%= link_to "Sign Up", signup_path, class: "btn btn-outline-primary nav-signup-btn" %></li>
      </ul>
    </div>
  </div>
</nav>
EOF

cat > app/views/layouts/_footer.html.erb <<'EOF'
<footer class="site-footer mt-auto">
  <div class="container py-5">
    <div class="row g-4 align-items-start">
      <div class="col-lg-5">
        <%= link_to root_path, class: "footer-brand" do %>
          <span class="brand-mark">A</span><span>Alpha Blog</span>
        <% end %>
        <p class="footer-description mt-3">A simple place to share ideas, discover stories, and connect with people who love writing.</p>
      </div>
      <div class="col-6 col-lg-2">
        <h6>Explore</h6>
        <ul class="list-unstyled footer-links">
          <li><%= link_to "Home", root_path %></li>
          <li><%= link_to "Articles", articles_path %></li>
          <li><%= link_to "Bloggers", users_path %></li>
          <li><%= link_to "About", about_path %></li>
        </ul>
      </div>
      <div class="col-6 col-lg-2">
        <h6>Start Writing</h6>
        <ul class="list-unstyled footer-links">
          <li><%= link_to "Sign Up", signup_path %></li>
          <li><%= link_to "Create Article", new_article_path %></li>
        </ul>
      </div>
    </div>
    <hr class="footer-divider">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
      <small>© <%= Time.current.year %> <%= link_to "Alpha Blog", root_path, class: "footer-copyright-link" %>. All rights reserved.</small>
      <small>Built with Ruby on Rails</small>
    </div>
  </div>
</footer>
EOF

cat > app/views/layouts/_messages.html.erb <<'EOF'
<div class="container flash-container">
  <% flash.each do |name, msg| %>
    <% alert_class = name.to_s == "notice" ? "alert-success" : "alert-danger" %>
    <div class="alert <%= alert_class %> alert-dismissible fade show modern-alert" role="alert">
      <div><strong><%= name.to_s == "notice" ? "Success!" : "Something went wrong!" %></strong> <span><%= msg %></span></div>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  <% end %>
</div>
EOF

cat > app/views/pages/home.html.erb <<'EOF'
<section class="hero-section">
  <div class="container">
    <div class="row align-items-center min-vh-75">
      <div class="col-lg-7">
        <span class="hero-badge">A place for ideas, stories and creativity</span>
        <h1 class="hero-title">Share your ideas.<span> Tell your story.</span></h1>
        <p class="hero-text">Alpha Blog is a community where you can create articles, discover new perspectives, and share your thoughts with others.</p>
        <div class="d-flex flex-wrap gap-3 hero-buttons">
          <%= link_to "Start Writing", signup_path, class: "btn btn-primary btn-lg px-4" %>
          <%= link_to "Explore Articles", articles_path, class: "btn btn-outline-dark btn-lg px-4" %>
        </div>
        <div class="hero-stats">
          <div><strong>Write</strong><span>Share your thoughts</span></div>
          <div><strong>Discover</strong><span>Explore new ideas</span></div>
          <div><strong>Connect</strong><span>Meet bloggers</span></div>
        </div>
      </div>
      <div class="col-lg-5 mt-5 mt-lg-0">
        <div class="hero-card">
          <div class="hero-card-top"><span class="hero-dot"></span><span class="hero-dot"></span><span class="hero-dot"></span></div>
          <div class="hero-card-content">
            <span class="article-label">FEATURED IDEA</span>
            <h2>Every great idea deserves a place to be shared.</h2>
            <p>Write about what inspires you and let your ideas travel further.</p>
            <div class="hero-author"><div class="hero-avatar">A</div><div><strong>Alpha Blogger</strong><span>Sharing ideas with the world</span></div></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<section class="home-feature-section">
  <div class="container">
    <div class="text-center section-heading"><span>WHY ALPHA BLOG?</span><h2>Everything you need to start sharing.</h2></div>
    <div class="row g-4">
      <div class="col-md-4"><div class="feature-card"><div class="feature-icon">✍</div><h3>Write freely</h3><p>Create articles and turn your thoughts into stories.</p></div></div>
      <div class="col-md-4"><div class="feature-card"><div class="feature-icon">◉</div><h3>Discover ideas</h3><p>Explore articles written by different Alpha Bloggers.</p></div></div>
      <div class="col-md-4"><div class="feature-card"><div class="feature-icon">♟</div><h3>Build your profile</h3><p>Create your profile and showcase your articles.</p></div></div>
    </div>
  </div>
</section>
EOF

cat > app/views/pages/about.html.erb <<'EOF'
<section class="page-hero">
  <div class="container text-center">
    <span class="section-kicker">ABOUT ALPHA BLOG</span>
    <h1>A simple platform built for sharing ideas.</h1>
    <p>Alpha Blog gives writers a place to publish their thoughts and readers a place to discover new perspectives.</p>
  </div>
</section>
<section class="about-section">
  <div class="container"><div class="row justify-content-center"><div class="col-lg-9">
    <div class="about-card">
      <h2>Why Alpha Blog?</h2>
      <p>Everyone has ideas worth sharing. Alpha Blog is a simple blogging platform where users can create an account, write articles, edit their work, and discover other bloggers.</p>
      <p>This project is built as part of a Ruby on Rails learning journey and continues to grow as new features are added.</p>
      <div class="about-actions"><%= link_to "Explore Articles", articles_path, class: "btn btn-primary" %><%= link_to "Meet the Bloggers", users_path, class: "btn btn-outline-primary" %></div>
    </div>
  </div></div></div>
</section>
EOF

cat > app/views/articles/index.html.erb <<'EOF'
<section class="listing-page">
  <div class="container">
    <div class="page-heading d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-3">
      <div><span class="section-kicker">THE COMMUNITY BLOG</span><h1>Latest Articles</h1><p>Discover thoughts, stories, and ideas from Alpha Bloggers.</p></div>
      <%= link_to "Write an Article", new_article_path, class: "btn btn-primary btn-lg" %>
    </div>
    <div class="articles-grid"><%= render "article", articles: @articles %></div>
  </div>
</section>
EOF

cat > app/views/articles/_article.html.erb <<'EOF'
<% articles.each do |article| %>
  <article class="article-card">
    <div class="article-card-body">
      <div class="article-meta">
        <div class="article-author">
          <div class="author-initial"><%= article.user.username.first.upcase %></div>
          <div><span>Written by</span><strong><%= link_to article.user.username, user_path(article.user), class: "author-link" %></strong></div>
        </div>
        <span class="article-date"><%= time_ago_in_words(article.created_at) %> ago</span>
      </div>
      <h2><%= link_to article.title, article_path(article), class: "article-title-link" %></h2>
      <p class="article-description"><%= truncate(article.description, length: 180) %></p>
      <div class="article-actions">
        <%= link_to "Read Article →", article_path(article), class: "read-more-link" %>
        <div class="article-manage-actions">
          <%= link_to "Edit", edit_article_path(article), class: "btn btn-sm btn-outline-primary" %>
          <%= link_to "Delete", article_path(article), class: "btn btn-sm btn-outline-danger", data: { turbo_method: :delete, turbo_confirm: "Are you sure you want to delete this article?" } %>
        </div>
      </div>
    </div>
    <div class="article-card-footer"><span>Created <%= time_ago_in_words(article.created_at) %> ago</span><span>Updated <%= time_ago_in_words(article.updated_at) %> ago</span></div>
  </article>
<% end %>
EOF

cat > app/views/articles/show.html.erb <<'EOF'
<section class="article-show-page">
  <div class="container"><div class="article-show-wrapper">
    <%= link_to "← Back to Articles", articles_path, class: "back-link" %>
    <article class="article-show-card">
      <div class="article-show-header">
        <div class="article-author"><div class="author-initial"><%= @article.user.username.first.upcase %></div><div><span>Written by</span><strong><%= link_to @article.user.username, user_path(@article.user), class: "author-link" %></strong></div></div>
        <span class="article-date"><%= time_ago_in_words(@article.created_at) %> ago</span>
      </div>
      <h1><%= @article.title %></h1>
      <div class="article-content"><%= simple_format(@article.description) %></div>
      <div class="article-show-footer">
        <div class="article-timestamps"><span>Created <%= time_ago_in_words(@article.created_at) %> ago</span><span>Updated <%= time_ago_in_words(@article.updated_at) %> ago</span></div>
        <div class="d-flex flex-wrap gap-2">
          <%= link_to "Edit Article", edit_article_path(@article), class: "btn btn-primary" %>
          <%= link_to "Delete", article_path(@article), class: "btn btn-outline-danger", data: { turbo_method: :delete, turbo_confirm: "Are you sure you want to delete this article?" } %>
        </div>
      </div>
    </article>
  </div></div>
</section>
EOF

cat > app/views/articles/new.html.erb <<'EOF'
<section class="form-page"><div class="container"><div class="form-page-heading"><span class="section-kicker">CREATE</span><h1>Write a New Article</h1><p>Share an idea, story, or something you've learned.</p></div><%= render "form" %></div></section>
EOF

cat > app/views/articles/edit.html.erb <<'EOF'
<section class="form-page"><div class="container"><div class="form-page-heading"><span class="section-kicker">EDIT</span><h1>Update Your Article</h1><p>Make changes and keep your article up to date.</p></div><%= render "form" %></div></section>
EOF

cat > app/views/articles/_form.html.erb <<'EOF'
<div class="form-card">
  <%= render "shared/errors", obj: @article %>
  <%= form_with(model: @article, local: true, data: { turbo: false }) do |f| %>
    <div class="mb-4"><%= f.label :title, "Article Title", class: "form-label" %><%= f.text_field :title, class: "form-control form-control-lg", placeholder: "Give your article an interesting title" %></div>
    <div class="mb-4"><%= f.label :description, "Your Article", class: "form-label" %><%= f.text_area :description, class: "form-control article-textarea", rows: 10, placeholder: "Start writing your article here..." %></div>
    <div class="form-actions"><%= f.submit(@article.new_record? ? "Publish Article" : "Update Article", class: "btn btn-primary btn-lg") %><%= link_to "Cancel", articles_path, class: "btn btn-light btn-lg" %></div>
  <% end %>
</div>
EOF

cat > app/views/users/index.html.erb <<'EOF'
<section class="listing-page"><div class="container">
  <div class="page-heading text-center mb-5"><span class="section-kicker">OUR COMMUNITY</span><h1>Alpha Bloggers</h1><p>Meet the people who are sharing their thoughts and stories.</p></div>
  <div class="row g-4">
    <% @users.each do |user| %>
      <div class="col-sm-6 col-lg-4"><div class="user-card">
        <div class="user-card-avatar"><%= link_to gravatar_for(user, size: 160), user_path(user) %></div>
        <h3><%= link_to user.username, user_path(user), class: "user-name-link" %></h3>
        <p class="user-article-count"><%= pluralize(user.articles.count, "article") %> published</p>
        <div class="d-flex justify-content-center gap-2"><%= link_to "View Profile", user_path(user), class: "btn btn-primary" %><%= link_to "Edit", edit_user_path(user), class: "btn btn-outline-primary" %></div>
        <div class="user-card-footer">Joined <%= time_ago_in_words(user.created_at) %> ago</div>
      </div></div>
    <% end %>
  </div>
</div></section>
EOF

cat > app/views/users/show.html.erb <<'EOF'
<section class="profile-page"><div class="container">
  <div class="profile-header-card">
    <div class="profile-avatar"><%= gravatar_for @user, size: 200 %></div>
    <div class="profile-details"><span class="section-kicker">ALPHA BLOGGER</span><h1><%= @user.username %></h1><p>Member for <%= time_ago_in_words(@user.created_at) %></p><div class="profile-actions"><%= link_to "Edit Profile", edit_user_path(@user), class: "btn btn-primary" %><%= link_to "Browse Articles", articles_path, class: "btn btn-outline-primary" %></div></div>
    <div class="profile-stat"><strong><%= @user.articles.count %></strong><span><%= @user.articles.count == 1 ? "Article" : "Articles" %></span></div>
  </div>
  <div class="profile-articles-section">
    <div class="section-title-row"><div><span class="section-kicker">WRITING</span><h2><%= @user.username %>'s Articles</h2></div><%= link_to "Write New Article", new_article_path, class: "btn btn-primary" %></div>
    <% if @articles.any? %>
      <div class="articles-grid"><%= render "articles/article", articles: @articles %></div>
    <% else %>
      <div class="empty-state"><div class="empty-state-icon">✍</div><h3>No articles yet</h3><p><%= @user.username %> hasn't published anything yet.</p><%= link_to "Create the First Article", new_article_path, class: "btn btn-primary" %></div>
    <% end %>
  </div>
</div></section>
EOF

cat > app/views/users/new.html.erb <<'EOF'
<section class="form-page"><div class="container"><div class="form-page-heading"><span class="section-kicker">JOIN THE COMMUNITY</span><h1>Create Your Account</h1><p>Start writing and sharing your ideas with Alpha Blog.</p></div><%= render "form" %></div></section>
EOF

cat > app/views/users/edit.html.erb <<'EOF'
<section class="form-page"><div class="container"><div class="form-page-heading"><span class="section-kicker">YOUR ACCOUNT</span><h1>Update Your Profile</h1><p>Keep your account information up to date.</p></div><%= render "form" %></div></section>
EOF

cat > app/views/users/_form.html.erb <<'EOF'
<div class="form-card user-form-card">
  <%= render "shared/errors", obj: @user %>
  <%= form_with(model: @user, local: true, data: { turbo: false }) do |f| %>
    <div class="mb-4"><%= f.label :username, class: "form-label" %><%= f.text_field :username, class: "form-control form-control-lg", placeholder: "Choose a username" %></div>
    <div class="mb-4"><%= f.label :email, class: "form-label" %><%= f.email_field :email, class: "form-control form-control-lg", placeholder: "Enter your email address" %></div>
    <div class="mb-4"><%= f.label :password, class: "form-label" %><%= f.password_field :password, class: "form-control form-control-lg", placeholder: @user.new_record? ? "Create a secure password" : "Enter a new password" %></div>
    <div class="form-actions"><%= f.submit(@user.new_record? ? "Create Account" : "Update Profile", class: "btn btn-primary btn-lg") %><%= link_to "Cancel", articles_path, class: "btn btn-light btn-lg" %></div>
  <% end %>
</div>
EOF

cat > app/views/shared/_errors.html.erb <<'EOF'
<% if obj.errors.any? %>
  <div class="validation-errors">
    <div class="validation-errors-title">Please fix the following <%= pluralize(obj.errors.count, "error") %>:</div>
    <ul><% obj.errors.full_messages.each do |msg| %><li><%= msg %></li><% end %></ul>
  </div>
<% end %>
EOF

cat > app/javascript/application.js <<'EOF'
import "@hotwired/turbo-rails"
import "controllers"
EOF

cat > app/assets/stylesheets/application.css <<'EOF'
/*
 *= require_tree .
 *= require_self
 */
:root{--primary:#5b5ce2;--primary-dark:#4546c7;--primary-light:#efefff;--dark:#17172a;--text:#5f6075;--muted:#8d8fa3;--border:#e9e9f1;--background:#f8f9fc}
html,body{min-height:100%}body{min-height:100vh;background:var(--background);color:var(--dark);font-family:Arial,Helvetica,sans-serif}a{transition:all .2s ease}main{overflow:hidden}.btn{border-radius:10px;font-weight:600;padding:.65rem 1rem}.btn-primary{background:var(--primary);border-color:var(--primary)}.btn-primary:hover,.btn-primary:focus{background:var(--primary-dark);border-color:var(--primary-dark)}.btn-outline-primary{color:var(--primary);border-color:var(--primary)}.btn-outline-primary:hover{background:var(--primary);border-color:var(--primary)}.section-kicker,.section-heading>span{display:inline-block;color:var(--primary);font-size:.75rem;font-weight:800;letter-spacing:.12em;margin-bottom:.75rem}
.site-navbar{background:rgba(255,255,255,.95);border-bottom:1px solid var(--border);backdrop-filter:blur(10px);padding:.8rem 0}.brand-logo,.footer-brand{display:inline-flex;align-items:center;gap:.7rem;color:var(--dark);font-size:1.15rem;font-weight:800;text-decoration:none}.brand-logo:hover{color:var(--primary)}.brand-mark{display:inline-flex;align-items:center;justify-content:center;width:38px;height:38px;color:#fff;background:linear-gradient(135deg,var(--primary),#8b5cf6);border-radius:11px;font-weight:800}.nav-link{color:#65667a!important;font-weight:600;padding:.55rem .75rem!important}.nav-link:hover{color:var(--primary)!important}.nav-action-btn,.nav-signup-btn{font-size:.9rem}
.flash-container{position:relative;z-index:10}.modern-alert{margin-top:1.25rem;border:0;border-radius:14px;box-shadow:0 10px 25px rgba(30,30,60,.08)}
.hero-section{background:radial-gradient(circle at 80% 20%,rgba(139,92,246,.16),transparent 30%),radial-gradient(circle at 15% 80%,rgba(91,92,226,.12),transparent 35%),#fbfbff}.min-vh-75{min-height:75vh}.hero-badge{display:inline-block;padding:.55rem .9rem;margin-bottom:1.5rem;background:var(--primary-light);color:var(--primary);border-radius:50px;font-size:.85rem;font-weight:700}.hero-title{max-width:700px;margin-bottom:1.25rem;font-size:clamp(3rem,6vw,5.5rem);font-weight:800;letter-spacing:-.05em;line-height:.98}.hero-title span{color:var(--primary)}.hero-text{max-width:620px;color:var(--text);font-size:1.15rem;line-height:1.8}.hero-buttons{margin-top:2rem}.hero-stats{display:flex;flex-wrap:wrap;gap:2rem;margin-top:3rem}.hero-stats div{display:flex;flex-direction:column}.hero-stats strong{color:var(--dark);font-size:1.05rem}.hero-stats span{color:var(--muted);font-size:.85rem}.hero-card{overflow:hidden;background:#fff;border:1px solid var(--border);border-radius:24px;box-shadow:0 30px 70px rgba(49,49,91,.15);transform:rotate(2deg)}.hero-card-top{display:flex;gap:7px;padding:1rem 1.25rem;border-bottom:1px solid var(--border)}.hero-dot{width:9px;height:9px;background:#d7d7e2;border-radius:50%}.hero-card-content{padding:2.5rem}.article-label{color:var(--primary);font-size:.7rem;font-weight:800;letter-spacing:.12em}.hero-card-content h2{margin:1rem 0;font-size:2rem;font-weight:800;line-height:1.2}.hero-card-content>p{color:var(--text);line-height:1.7}.hero-author{display:flex;align-items:center;gap:.8rem;margin-top:2rem}.hero-avatar{display:flex;align-items:center;justify-content:center;width:45px;height:45px;color:#fff;background:var(--dark);border-radius:50%;font-weight:700}.hero-author strong,.hero-author span{display:block}.hero-author span{color:var(--muted);font-size:.8rem}
.home-feature-section{padding:7rem 0;background:#fff}.section-heading{max-width:650px;margin:0 auto 3rem}.section-heading h2{font-size:clamp(2rem,4vw,3rem);font-weight:800}.feature-card{height:100%;padding:2rem;background:var(--background);border:1px solid var(--border);border-radius:20px;transition:transform .25s ease,box-shadow .25s ease}.feature-card:hover,.article-card:hover,.user-card:hover{transform:translateY(-6px);box-shadow:0 25px 50px rgba(30,30,60,.1)}.feature-icon{display:flex;align-items:center;justify-content:center;width:52px;height:52px;margin-bottom:1.5rem;color:var(--primary);background:var(--primary-light);border-radius:15px;font-size:1.5rem}.feature-card h3{font-size:1.25rem;font-weight:800}.feature-card p{margin-bottom:0;color:var(--text);line-height:1.7}
.page-hero{padding:7rem 0 5rem;background:linear-gradient(180deg,#fff,var(--background))}.page-hero h1{max-width:800px;margin:0 auto 1rem;font-size:clamp(2.5rem,5vw,4.5rem);font-weight:800;letter-spacing:-.04em}.page-hero p{max-width:650px;margin:auto;color:var(--text);font-size:1.1rem;line-height:1.8}.about-section{padding:2rem 0 7rem}.about-card{padding:3rem;background:#fff;border:1px solid var(--border);border-radius:24px;box-shadow:0 20px 50px rgba(30,30,60,.06)}.about-card h2{margin-bottom:1.5rem;font-weight:800}.about-card p{color:var(--text);line-height:1.9}.about-actions{display:flex;flex-wrap:wrap;gap:.75rem;margin-top:2rem}
.listing-page{padding:4rem 0 6rem}.page-heading{margin-bottom:3rem}.page-heading h1{margin-bottom:.75rem;font-size:clamp(2.2rem,4vw,3.5rem);font-weight:800;letter-spacing:-.04em}.page-heading p{max-width:650px;margin-bottom:0;color:var(--text);font-size:1.05rem}.articles-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:1.5rem}.article-card{display:flex;flex-direction:column;overflow:hidden;height:100%;background:#fff;border:1px solid var(--border);border-radius:20px;transition:transform .25s ease,box-shadow .25s ease}.article-card-body{padding:1.75rem}.article-meta,.article-actions,.article-show-header,.article-show-footer{display:flex;justify-content:space-between;gap:1rem}.article-meta{align-items:flex-start;margin-bottom:1.5rem}.article-author{display:flex;align-items:center;gap:.75rem}.author-initial{display:flex;align-items:center;justify-content:center;width:43px;height:43px;color:var(--primary);background:var(--primary-light);border-radius:50%;font-weight:800}.article-author span,.article-author strong{display:block}.article-author span{color:var(--muted);font-size:.75rem}.author-link{color:var(--dark);text-decoration:none}.author-link:hover,.article-title-link:hover{color:var(--primary)}.article-date{color:var(--muted);font-size:.8rem;white-space:nowrap}.article-card h2{margin-bottom:1rem;font-size:1.45rem;font-weight:800;line-height:1.3}.article-title-link{color:var(--dark);text-decoration:none}.article-description{color:var(--text);line-height:1.75}.article-actions{align-items:center;margin-top:1.75rem}.read-more-link,.back-link{color:var(--primary);font-weight:700;text-decoration:none}.article-manage-actions{display:flex;gap:.5rem}.article-card-footer{display:flex;justify-content:space-between;gap:1rem;margin-top:auto;padding:1rem 1.75rem;color:var(--muted);background:#fafaff;border-top:1px solid var(--border);font-size:.75rem}
.article-show-page{padding:3rem 0 6rem}.article-show-wrapper{max-width:900px;margin:auto}.back-link{display:inline-block;margin-bottom:1.5rem}.article-show-card{padding:2.5rem;background:#fff;border:1px solid var(--border);border-radius:24px;box-shadow:0 20px 60px rgba(30,30,60,.08)}.article-show-header{align-items:center;margin-bottom:2.5rem}.article-show-card h1{margin-bottom:2rem;font-size:clamp(2rem,5vw,3.5rem);font-weight:800;letter-spacing:-.04em;line-height:1.15}.article-content{color:#47485c;font-size:1.08rem;line-height:1.9}.article-show-footer{align-items:center;margin-top:3rem;padding-top:1.5rem;border-top:1px solid var(--border)}.article-timestamps{display:flex;flex-direction:column;gap:.3rem;color:var(--muted);font-size:.8rem}
.form-page{padding:4rem 0 6rem}.form-page-heading{max-width:650px;margin:0 auto 2rem;text-align:center}.form-page-heading h1{margin-bottom:.75rem;font-size:clamp(2rem,4vw,3rem);font-weight:800}.form-page-heading p{color:var(--text)}.form-card{max-width:800px;margin:auto;padding:2.5rem;background:#fff;border:1px solid var(--border);border-radius:24px;box-shadow:0 20px 60px rgba(30,30,60,.08)}.form-label{margin-bottom:.6rem;color:var(--dark);font-weight:700}.form-control{padding:.85rem 1rem;border-color:#dedee9;border-radius:12px}.form-control:focus{border-color:var(--primary);box-shadow:0 0 0 .2rem rgba(91,92,226,.12)}.article-textarea{min-height:240px;resize:vertical}.form-actions{display:flex;flex-wrap:wrap;gap:.75rem;padding-top:.5rem}.validation-errors{margin-bottom:1.5rem;padding:1.25rem 1.5rem;color:#842029;background:#fff1f2;border:1px solid #f5c2c7;border-radius:14px}.validation-errors-title{margin-bottom:.6rem;font-weight:800}.validation-errors ul{margin:0;padding-left:1.25rem}
.user-card{overflow:hidden;height:100%;padding:2rem;text-align:center;background:#fff;border:1px solid var(--border);border-radius:20px;transition:transform .25s ease,box-shadow .25s ease}.user-card-avatar img{width:110px;height:110px;margin-bottom:1.25rem;border:5px solid var(--primary-light);border-radius:50%}.user-card h3{margin-bottom:.4rem;font-size:1.25rem;font-weight:800}.user-name-link{color:var(--dark);text-decoration:none}.user-name-link:hover{color:var(--primary)}.user-article-count{margin-bottom:1.5rem;color:var(--muted)}.user-card-footer{margin:1.75rem -2rem -2rem;padding:1rem;color:var(--muted);background:#fafaff;border-top:1px solid var(--border);font-size:.8rem}
.profile-page{padding:4rem 0 6rem}.profile-header-card{display:grid;grid-template-columns:auto 1fr auto;gap:2rem;align-items:center;padding:2.5rem;margin-bottom:4rem;background:#fff;border:1px solid var(--border);border-radius:24px;box-shadow:0 20px 60px rgba(30,30,60,.07)}.profile-avatar img{width:140px;height:140px;border:6px solid var(--primary-light);border-radius:50%}.profile-details h1{margin-bottom:.5rem;font-size:2.3rem;font-weight:800}.profile-details p{color:var(--text)}.profile-actions{display:flex;flex-wrap:wrap;gap:.75rem;margin-top:1.25rem}.profile-stat{min-width:110px;padding:1.25rem;text-align:center;background:var(--primary-light);border-radius:18px}.profile-stat strong{display:block;color:var(--primary);font-size:2rem}.profile-stat span{color:var(--text);font-size:.8rem;font-weight:600}.profile-articles-section h2{margin-bottom:0;font-weight:800}.section-title-row{display:flex;justify-content:space-between;align-items:end;gap:1rem;margin-bottom:2rem}.empty-state{padding:4rem 2rem;text-align:center;background:#fff;border:1px dashed #cfcfe1;border-radius:24px}.empty-state-icon{margin-bottom:1rem;color:var(--primary);font-size:3rem}.empty-state h3{font-weight:800}.empty-state p{color:var(--text)}
.site-footer{color:#d8d8e5;background:#17172a}.site-footer .footer-brand{color:#fff}.footer-description{max-width:400px;color:#a6a7b8;line-height:1.7}.site-footer h6{margin-bottom:1rem;color:#fff;font-weight:700}.footer-links li{margin-bottom:.6rem}.footer-links a,.footer-copyright-link{color:#a6a7b8;text-decoration:none}.footer-links a:hover,.footer-copyright-link:hover{color:#fff}.footer-divider{margin:2rem 0;border-color:rgba(255,255,255,.1)}
@media(max-width:991.98px){.navbar-collapse{padding-top:1rem}.nav-action-btn,.nav-signup-btn{margin-top:.5rem;width:100%}.articles-grid{grid-template-columns:1fr}.profile-header-card{grid-template-columns:1fr;text-align:center}.profile-avatar{text-align:center}.profile-actions{justify-content:center}.profile-stat{justify-self:center}}@media(max-width:767.98px){.hero-title{font-size:3rem}.hero-card{transform:none}.page-heading,.section-title-row{text-align:center}.section-title-row{align-items:center;flex-direction:column}.article-card-footer,.article-show-header,.article-show-footer{flex-direction:column}.article-show-card,.form-card,.about-card{padding:1.5rem}.article-manage-actions{flex-wrap:wrap}}
EOF

echo
echo "=========================================="
echo "UI redesign files have been updated."
echo "=========================================="
echo
echo "Current branch:"
git branch --show-current
echo
echo "Changed files:"
git status --short
echo
echo "Next:"
echo "bin/rails server"
