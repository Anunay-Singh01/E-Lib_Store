<%@page import="java.util.List"%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
List<BookDTO> books = (List<BookDTO>)request.getAttribute("books");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>E-lib Store</title>
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
        gap: 10px;
    }

    .btn-nav {
        height: 34px;
        padding: 0 16px;
        border-radius: 7px;
        font-size: 13px;
        font-weight: 600;
        font-family: Arial, sans-serif;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        transition: background 0.15s, transform 0.1s;
    }

    .btn-nav i { font-size: 15px; }

    .btn-nav-outline {
        background: transparent;
        color: #c8c4f0;
        border: 1px solid rgba(174,169,236,0.35);
    }

    .btn-nav-outline:hover { background: rgba(174,169,236,0.12); }

    .btn-nav-filled {
        background: #4e4798;
        color: #eeedf8;
        border: none;
    }

    .btn-nav-filled:hover { background: #3b3478; }

    /* ── Hero ── */
    .hero {
        background: #2e2b4a;
        padding: 52px 32px 48px;
        text-align: center;
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

    .hero-content { position: relative; z-index: 1; }

    .hero h1 {
        font-size: 32px;
        font-weight: 600;
        color: #eeedf8;
        margin-bottom: 10px;
    }

    .hero p {
        font-size: 15px;
        color: #a8a4cc;
        max-width: 480px;
        margin: 0 auto;
        line-height: 1.6;
    }

    /* ── Section ── */
    .section {
        max-width: 1100px;
        margin: 0 auto;
        padding: 40px 24px 56px;
    }

    .section-heading {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 28px;
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

    .book-card:hover .book-cover img {
        transform: scale(1.04);
    }

    .book-cover .no-cover {
        width: 100%;
        height: 100%;
        display: none;
        align-items: center;
        justify-content: center;
    }

    .book-cover .no-cover i {
        font-size: 44px;
        color: #9b99b8;
    }

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

    /* ── Empty state ── */
    .empty-state {
        text-align: center;
        padding: 64px 24px;
        color: #9b99b8;
    }

    .empty-state i { font-size: 52px; margin-bottom: 14px; display: block; }
    .empty-state p { font-size: 15px; }

    /* ── Footer ── */
    .footer {
        background: #2e2b4a;
        text-align: center;
        padding: 20px;
        font-size: 13px;
        color: #7a7896;
    }

    @media (max-width: 560px) {
        .hero h1 { font-size: 24px; }
        .books-grid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); }
        .navbar { padding: 0 16px; }
        .section { padding: 28px 16px 40px; }
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
            <a href="login.html" class="btn-nav btn-nav-outline">
                <i class="ti ti-login"></i>
                Sign in
            </a>
            <a href="registration.html" class="btn-nav btn-nav-filled">
                <i class="ti ti-user-plus"></i>
                Register
            </a>
        </div>
    </nav>

    <!-- Hero -->
    <div class="hero">
        <div class="hero-content">
            <h1>Find your next great read</h1>
            <p>Browse our collection of physical books available to borrow or buy. New and pre-loved titles, all in one place.</p>
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
            <i class="ti ti-books"></i>
            <p>No books listed yet. Check back soon!</p>
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

    <!-- Footer -->
    <div class="footer">
        &copy; 2026 E-lib Store &nbsp;·&nbsp; All rights reserved
    </div>

</body>
</html>