<!-- filepath: views/layout.erb -->
<!DOCTYPE html>
<html>
<head>
  <title>CloverWallet</title>
  <link rel="stylesheet" href="/css/style.css">
  <script src="/js/main.js" defer></script>
</head>
<body>
  <header class="main-header">
    <div class="logo-title">
      <!-- SVG de trébol verde -->
      <svg width="36" height="36" viewBox="0 0 32 32" fill="green" xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;">
        <circle cx="10" cy="10" r="7"/>
        <circle cx="22" cy="10" r="7"/>
        <circle cx="10" cy="22" r="7"/>
        <circle cx="22" cy="22" r="7"/>
        <rect x="14" y="14" width="4" height="14" rx="2" fill="green"/>
      </svg>
      <h1>CloverWallet</h1>
    </div>
    <nav>
      <% if session[:dni] %>
        <a href="/welcome">Home</a> |
        <a href="/dashboard">My Balance</a> |
        <a href="/deposit">Deposit</a> |
        <a href="/withdraw">Withdraw</a> |
        <a href="/transfer">Transfer</a> |
        <a href="/logout">Close session</a>
      <% else %>
        <a href="/signup">Sign Up</a> |
        <a href="/login">Sing In</a>
      <% end %>
    </nav>
    <hr>
  </header>

  <% if @error %>
    <p style="color: red;"><%= @error %></p>
  <% end %>

  <%= yield %>
</body>
</html>