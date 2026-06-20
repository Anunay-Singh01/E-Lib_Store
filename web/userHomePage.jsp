<%@page import="dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
List<BookDTO> books = (List<BookDTO>)request.getAttribute("books");
UserDTO user = (UserDTO)session.getAttribute("user");
if (user == null || user.getUsername() == null) {
    response.sendRedirect("login.html");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dashboard – E-lib Store</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
        font-family: Arial, sans-serif;
        background: #e8e6f0;
        min-height: 100vh;
        color: #2e2b4a;
    }

    /* ── Navbar ── */
    .navbar {
        background: #2e2b4a;
        padding: 0 32px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
    }

    .navbar-brand .nav-icon {
        width: 34px; height: 34px;
        background: rgba(174,169,236,0.18);
        border-radius: 8px;
        display: flex; align-items: center; justify-content: center;
    }

    .navbar-brand .nav-icon i { font-size: 19px; color: #c8c4f0; }
    .navbar-brand span { font-size: 17px; font-weight: 600; color: #eeedf8; }

    .navbar-links {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .btn-nav {
        height: 34px;
        padding: 0 14px;
        border-radius: 7px;
        font-size: 13px;
        font-weight: 600;
        font-family: Arial, sans-serif;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        transition: background 0.15s;
        border: none;
        white-space: nowrap;
    }

    .btn-nav i { font-size: 15px; }

    .btn-nav-ghost {
        background: transparent;
        color: #a8a4cc;
    }

    .btn-nav-ghost:hover { background: rgba(174,169,236,0.12); color: #eeedf8; }

    .btn-nav-outline {
        background: transparent;
        color: #c8c4f0;
        border: 1px solid rgba(174,169,236,0.35);
    }

    .btn-nav-outline:hover { background: rgba(174,169,236,0.12); }

    .btn-nav-danger {
        background: transparent;
        color: #e89090;
        border: 1px solid rgba(220,100,100,0.3);
    }

    .btn-nav-danger:hover { background: rgba(220,100,100,0.1); }

    .nav-divider {
        width: 1px;
        height: 22px;
        background: rgba(174,169,236,0.2);
        margin: 0 4px;
    }

    /* ── Hero ── */
    .hero {
        background: #2e2b4a;
        padding: 40px 32px 36px;
        position: relative;
        overflow: hidden;
    }

    .hero::before {
        content: '';
        position: absolute;
        top: -80px; left: -80px;
        width: 300px; height: 300px;
        border-radius: 50%;
        background: rgba(83,74,183,0.18);
    }

    .hero::after {
        content: '';
        position: absolute;
        bottom: -60px; right: -60px;
        width: 220px; height: 220px;
        border-radius: 50%;
        background: rgba(29,158,117,0.12);
    }

    .hero-content {
        position: relative;
        z-index: 1;
        max-width: 1100px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 24px;
        flex-wrap: wrap;
    }

    .hero-text h1 {
        font-size: 26px;
        font-weight: 600;
        color: #eeedf8;
        margin-bottom: 4px;
    }

    .hero-text p {
        font-size: 14px;
        color: #a8a4cc;
    }

    /* ── Search bar ── */
    .search-form {
        display: flex;
        gap: 0;
        border-radius: 9px;
        overflow: hidden;
        border: 1px solid rgba(174,169,236,0.3);
        background: rgba(255,255,255,0.06);
    }

    .search-form input {
        height: 40px;
        width: 260px;
        padding: 0 16px;
        background: transparent;
        border: none;
        color: #eeedf8;
        font-size: 14px;
        font-family: Arial, sans-serif;
        outline: none;
    }

    .search-form input::placeholder { color: #7a78a0; }

    .search-form button {
        height: 40px;
        padding: 0 18px;
        background: #4e4798;
        color: #eeedf8;
        border: none;
        font-size: 13px;
        font-weight: 600;
        font-family: Arial, sans-serif;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 6px;
        transition: background 0.15s;
    }

    .search-form button:hover { background: #3b3478; }
    .search-form button i { font-size: 16px; }

    /* ── Section ── */
    .section {
        max-width: 1100px;
        margin: 0 auto;
        padding: 36px 24px 64px;
    }

    .section-heading {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 26px;
    }

    .section-heading i { font-size: 20px; color: #6c63b8; }

    .section-heading h2 {
        font-size: 18px;
        font-weight: 600;
        color: #2e2b4a;
    }

    /* ── Books grid ── */
    .books-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(190px, 1fr));
        gap: 22px;
    }

    .book-card {
        background: #f2f0f7;
        border-radius: 13px;
        border: 1px solid #d4d2e3;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        text-decoration: none;
        color: inherit;
        transition: box-shadow 0.15s, transform 0.15s;
    }

    .book-card:hover {
        box-shadow: 0 6px 22px rgba(78,71,152,0.15);
        transform: translateY(-3px);
    }

    .book-cover {
        width: 100%;
        aspect-ratio: 3/4;
        overflow: hidden;
        background: #dddaf0;
        position: relative;
    }

    .book-cover img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        transition: transform 0.3s;
    }

    .book-card:hover .book-cover img { transform: scale(1.04); }

    .book-cover .no-cover {
        width: 100%; height: 100%;
        display: none;
        align-items: center;
        justify-content: center;
    }

    .book-cover .no-cover i { font-size: 44px; color: #9b99b8; }

    .book-info {
        padding: 13px 15px 15px;
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 3px;
    }

    .book-title {
        font-size: 14px;
        font-weight: 600;
        color: #2e2b4a;
        line-height: 1.35;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .book-author {
        font-size: 12px;
        color: #7a7896;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .book-price {
        font-size: 15px;
        font-weight: 600;
        color: #4e4798;
        margin-top: 8px;
    }

    /* ── Empty / no results ── */
    .empty-state {
        text-align: center;
        padding: 64px 24px;
        color: #9b99b8;
    }

    .empty-state i { font-size: 52px; margin-bottom: 14px; display: block; }
    .empty-state h3 { font-size: 16px; font-weight: 600; color: #7a7896; margin-bottom: 6px; }
    .empty-state p { font-size: 14px; }

    /* ── Footer ── */
    .footer {
        background: #2e2b4a;
        text-align: center;
        padding: 20px;
        font-size: 13px;
        color: #7a7896;
    }

    @media (max-width: 640px) {
        .navbar { padding: 0 16px; }
        .hero { padding: 28px 16px; }
        .hero-content { flex-direction: column; align-items: flex-start; }
        .search-form { width: 100%; }
        .search-form input { width: 100%; }
        .books-grid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); }
        .section { padding: 24px 16px 48px; }
        .btn-nav span { display: none; }
    }
</style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <a href="#" class="navbar-brand">
            <div class="nav-icon"><i class="ti ti-book-2"></i></div>
            <span>E-lib Store</span>
        </a>
        <div class="navbar-links">
            <a href="ViewCart" class="btn-nav btn-nav-ghost">
                <i class="ti ti-shopping-cart"></i>
                <span>Cart</span>
            </a>
            <a href="AddBook" class="btn-nav btn-nav-ghost">
                <i class="ti ti-layout-dashboard"></i>
                <span>Seller</span>
            </a>
            <a href="adminPanel.jsp" class="btn-nav btn-nav-ghost">
                <i class="ti ti-user-circle"></i>
                <span>Profile</span>
            </a>
            <div class="nav-divider"></div>
            <a href="logout.jsp" class="btn-nav btn-nav-danger">
                <i class="ti ti-logout"></i>
                <span>Logout</span>
            </a>
        </div>
    </nav>

    <!-- Hero with search -->
    <div class="hero">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Hello, <%=user.getUsername()%> 👋</h1>
                <p>Browse and reserve physical books from our collection.</p>
            </div>
            <form action="SearchBook" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="Search by title or author..." />
                <button type="submit">
                    <i class="ti ti-search"></i>
                    Search
                </button>
            </form>
        </div>
    </div>

    <!-- Books section -->
    <div class="section">
        <div class="section-heading">
            <i class="ti ti-books"></i>
            <h2>Featured books</h2>
        </div>

        <%
            if (books == null || books.isEmpty()) {
        %>
        <div class="empty-state">
            <i class="ti ti-zoom-cancel"></i>
            <h3>No books found</h3>
            <p>Try a different search keyword.</p>
        </div>
        <%
            } else {
        %>
        <div class="books-grid">
            <%
                for (BookDTO book : books) {
            %>
            <a href="BookDescription?bookid=<%=book.getBookid()%>" class="book-card">
                <div class="book-cover">
                    <img src="BookCoverDisplay?bookid=<%=book.getBookid()%>"
                         alt="<%=book.getBooktitle()%>"
                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                    <div class="no-cover">
                        <i class="ti ti-book-off"></i>
                    </div>
                </div>
                <div class="book-info">
                    <div class="book-title"><%=book.getBooktitle()%></div>
                    <div class="book-author"><%=book.getBookauthor()%></div>
                    <div class="book-price">₹<%=book.getBookprice()%></div>
                </div>
            </a>
            <%
                }
            %>
        </div>
        <%
            }
        %>
    </div>

    <div class="footer">
        &copy; 2026 E-lib Store &nbsp;·&nbsp; All rights reserved
    </div>

</body>
</html>