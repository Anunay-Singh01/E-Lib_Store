<%-- 
    Document   : bookdesc
    Created on : 30 May, 2026, 6:22:04 PM
    Author     : Anunay 
--%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%BookDTO book = (BookDTO)request.getAttribute("book");%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=book.getBooktitle()%> – E-lib Store</title>
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

            .navbar-right {
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
                transition: background 0.15s;
                border: none;
            }

            .btn-nav i { font-size: 15px; }

            .btn-nav-outline {
                background: transparent;
                color: #c8c4f0;
                border: 1px solid rgba(174,169,236,0.35);
            }

            .btn-nav-outline:hover { background: rgba(174,169,236,0.12); }

            .btn-nav-back {
                background: transparent;
                color: #a8a4cc;
                border: none;
                padding: 0 10px;
            }

            .btn-nav-back:hover { color: #eeedf8; }

            /* ── Page wrapper ── */
            .page-wrapper {
                max-width: 900px;
                margin: 0 auto;
                padding: 40px 24px 64px;
            }

            /* ── Toast message ── */
            .toast {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 13px 18px;
                border-radius: 10px;
                font-size: 14px;
                font-weight: 600;
                margin-bottom: 28px;
            }

            .toast i { font-size: 18px; }

            .toast-success {
                background: #d4f0e4;
                color: #0f6e56;
                border: 1px solid #a8ddc8;
            }

            .toast-warning {
                background: #fef3e2;
                color: #8a5a00;
                border: 1px solid #f0d898;
            }

            /* ── Main card ── */
            .book-detail-card {
                background: #f2f0f7;
                border-radius: 16px;
                border: 1px solid #d4d2e3;
                overflow: hidden;
                display: flex;
                gap: 0;
            }

            /* ── Cover panel ── */
            .cover-panel {
                width: 280px;
                flex-shrink: 0;
                background: #2e2b4a;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 32px 24px;
                position: relative;
            }

            .cover-panel::before {
                content: '';
                position: absolute;
                top: -60px; left: -60px;
                width: 180px; height: 180px;
                border-radius: 50%;
                background: rgba(83,74,183,0.18);
            }

            .cover-panel::after {
                content: '';
                position: absolute;
                bottom: -40px; right: -40px;
                width: 140px; height: 140px;
                border-radius: 50%;
                background: rgba(29,158,117,0.12);
            }

            .cover-img-wrap {
                width: 200px;
                height: 270px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 8px 28px rgba(0,0,0,0.35);
                position: relative;
                z-index: 1;
                background: #3d3a5c;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .cover-img-wrap img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .cover-img-wrap .no-cover {
                display: none;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 100%;
            }

            .cover-img-wrap .no-cover i {
                font-size: 52px;
                color: #6c63b8;
            }

            /* ── Info panel ── */
            .info-panel {
                flex: 1;
                padding: 36px 32px;
                display: flex;
                flex-direction: column;
            }

            .book-title {
                font-size: 24px;
                font-weight: 600;
                color: #2e2b4a;
                line-height: 1.3;
                margin-bottom: 6px;
            }

            .book-author {
                font-size: 15px;
                color: #7a7896;
                margin-bottom: 24px;
            }

            .book-author span { color: #4a4868; font-weight: 600; }

            /* ── Meta pills ── */
            .meta-row {
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
                margin-bottom: 28px;
            }

            .meta-pill {
                display: flex;
                align-items: center;
                gap: 7px;
                padding: 7px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            .meta-pill i { font-size: 15px; }

            .pill-price {
                background: #e8e6f8;
                color: #4e4798;
                border: 1px solid #c8c4e8;
            }

            .pill-new {
                background: #d4f0e4;
                color: #0f6e56;
                border: 1px solid #a8ddc8;
            }

            .pill-old {
                background: #f0e4d4;
                color: #7a3c1d;
                border: 1px solid #ddc0a8;
            }

            /* ── Divider ── */
            .info-divider {
                height: 1px;
                background: #d4d2e3;
                margin-bottom: 28px;
            }

            /* ── Actions ── */
            .action-row {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-top: auto;
            }

            .btn-cart {
                height: 44px;
                padding: 0 28px;
                background: #4e4798;
                color: #eeedf8;
                border: none;
                border-radius: 9px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-cart:hover { background: #3b3478; }
            .btn-cart:active { transform: scale(0.98); }
            .btn-cart i { font-size: 18px; }

            .btn-view-cart {
                height: 44px;
                padding: 0 20px;
                background: transparent;
                color: #6c63b8;
                border: 1px solid #c8c4e8;
                border-radius: 9px;
                font-size: 14px;
                font-weight: 600;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 7px;
                text-decoration: none;
                transition: background 0.15s;
            }

            .btn-view-cart:hover { background: #eceaf4; }
            .btn-view-cart i { font-size: 17px; }

            @media (max-width: 640px) {
                .book-detail-card { flex-direction: column; }
                .cover-panel { width: 100%; padding: 28px; }
                .cover-img-wrap { width: 160px; height: 215px; margin: 0 auto; }
                .info-panel { padding: 24px 20px; }
                .book-title { font-size: 20px; }
                .page-wrapper { padding: 24px 16px 48px; }
                .action-row { flex-direction: column; align-items: stretch; }
                .btn-cart, .btn-view-cart { justify-content: center; }
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
            <div class="navbar-right">
                <a href="javascript:history.back()" class="btn-nav btn-nav-back">
                    <i class="ti ti-arrow-left"></i>
                    Back
                </a>
                <a href="ViewCart" class="btn-nav btn-nav-outline">
                    <i class="ti ti-shopping-cart"></i>
                    View cart
                </a>
            </div>
        </nav>

        <div class="page-wrapper">

            <%
                String msg = request.getParameter("msg");
                if ("added".equals(msg)) {
            %>
            <div class="toast toast-success">
                <i class="ti ti-circle-check"></i>
                Book added to your cart successfully!
            </div>
            <%
                } else if ("exists".equals(msg)) {
            %>
            <div class="toast toast-warning">
                <i class="ti ti-alert-circle"></i>
                This book is already in your cart.
            </div>
            <%
                }
            %>

            <div class="book-detail-card">

                <!-- Cover -->
                <div class="cover-panel">
                    <div class="cover-img-wrap">
                        <img src="BookCoverDisplay?bookid=<%=book.getBookid()%>"
                             alt="<%=book.getBooktitle()%>"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                        <div class="no-cover">
                            <i class="ti ti-book-off"></i>
                        </div>
                    </div>
                </div>

                <!-- Info -->
                <div class="info-panel">

                    <div class="book-title"><%=book.getBooktitle()%></div>
                    <div class="book-author">by <span><%=book.getBookauthor()%></span></div>

                    <div class="meta-row">
                        <div class="meta-pill pill-price">
                            <i class="ti ti-currency-rupee"></i>
                            <%=book.getBookprice()%>
                        </div>
                        <div class="meta-pill <%="New".equals(book.getBookcondition()) ? "pill-new" : "pill-old"%>">
                            <i class="ti ti-tag"></i>
                            <%=book.getBookcondition()%>
                        </div>
                    </div>

                    <div class="info-divider"></div>

                    <div class="action-row">
                        <form action="AddToCart" method="post" style="display:contents;">
                            <input type="hidden" name="bookid" value="<%=book.getBookid()%>" />
                            <button type="submit" class="btn-cart">
                                <i class="ti ti-shopping-cart-plus"></i>
                                Add to cart
                            </button>
                        </form>
                        <a href="ViewCart" class="btn-view-cart">
                            <i class="ti ti-shopping-cart"></i>
                            View cart
                        </a>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>