<%-- 
    Document   : sellerDashboard
    Created on : 3 Jun, 2026, 5:04:57 PM
    Author     : Anunay 
--%>
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
        <title>Seller Dashboard – E-lib Store</title>
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
                height: 56px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .navbar-brand {
                display: flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
            }

            .navbar-brand .nav-icon {
                width: 32px; height: 32px;
                background: rgba(174,169,236,0.18);
                border-radius: 8px;
                display: flex; align-items: center; justify-content: center;
            }

            .navbar-brand .nav-icon i { font-size: 18px; color: #c8c4f0; }
            .navbar-brand span { font-size: 16px; font-weight: 600; color: #eeedf8; }

            .navbar-right {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 13px;
                color: #a8a4cc;
            }

            .navbar-right i { font-size: 16px; }

            /* ── Page wrapper ── */
            .page-wrapper {
                max-width: 1000px;
                margin: 0 auto;
                padding: 32px 24px 48px;
            }

            /* ── Section heading ── */
            .section-heading {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .section-heading i { font-size: 20px; color: #6c63b8; }

            .section-heading h2 {
                font-size: 18px;
                font-weight: 600;
                color: #2e2b4a;
            }

            /* ── Add book card ── */
            .add-book-card {
                background: #f2f0f7;
                border-radius: 14px;
                border: 1px solid #d4d2e3;
                padding: 28px 32px;
                margin-bottom: 40px;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .field { display: flex; flex-direction: column; gap: 6px; }
            .field.full-width { grid-column: 1 / -1; }

            .field label {
                font-size: 13px;
                font-weight: 600;
                color: #4a4868;
            }

            .input-wrap { position: relative; }

            .input-wrap .icon-left {
                position: absolute;
                left: 11px; top: 50%;
                transform: translateY(-50%);
                font-size: 16px;
                color: #9b99b8;
                pointer-events: none;
            }

            .input-wrap input,
            .input-wrap select {
                width: 100%;
                height: 40px;
                padding: 0 12px 0 36px;
                border: 1px solid #d4d2e3;
                border-radius: 8px;
                background: #eceaf4;
                color: #2e2b4a;
                font-size: 14px;
                font-family: Arial, sans-serif;
                outline: none;
                transition: border-color 0.15s, box-shadow 0.15s;
                appearance: none;
            }

            .input-wrap input:focus,
            .input-wrap select:focus {
                border-color: #6c63b8;
                box-shadow: 0 0 0 3px rgba(108,99,184,0.12);
                background: #ebe9f5;
            }

            /* file input */
            .file-field input[type="file"] {
                width: 100%;
                padding: 8px 12px;
                border: 1px dashed #b0aec8;
                border-radius: 8px;
                background: #eceaf4;
                color: #4a4868;
                font-size: 13px;
                font-family: Arial, sans-serif;
                cursor: pointer;
                outline: none;
            }

            .file-field input[type="file"]:focus {
                border-color: #6c63b8;
            }

            .form-actions {
                grid-column: 1 / -1;
                display: flex;
                justify-content: flex-end;
                margin-top: 4px;
            }

            .btn-primary {
                height: 40px;
                padding: 0 24px;
                background: #4e4798;
                color: #eeedf8;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-primary:hover { background: #3b3478; }
            .btn-primary:active { transform: scale(0.98); }
            .btn-primary i { font-size: 17px; }

            /* ── Books grid ── */
            .books-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 20px;
            }

            .book-card {
                background: #f2f0f7;
                border-radius: 12px;
                border: 1px solid #d4d2e3;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                transition: box-shadow 0.15s, transform 0.15s;
            }

            .book-card:hover {
                box-shadow: 0 4px 18px rgba(78,71,152,0.13);
                transform: translateY(-2px);
            }

            .book-cover-wrap {
                width: 100%;
                aspect-ratio: 3/4;
                background: #dddaf0;
                overflow: hidden;
                position: relative;
            }

            .book-cover-wrap img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                text-decoration: none;
            }

            .book-cover-wrap .no-cover {
                width: 100%;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .book-cover-wrap .no-cover i {
                font-size: 40px;
                color: #9b99b8;
            }

            .condition-badge {
                position: absolute;
                top: 8px; right: 8px;
                font-size: 11px;
                font-weight: 600;
                padding: 3px 8px;
                border-radius: 20px;
            }

            .badge-new {
                background: #d4f0e4;
                color: #0f6e56;
            }

            .badge-old {
                background: #f0e4d4;
                color: #7a3c1d;
            }

            .book-info {
                padding: 12px 14px;
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .book-title {
                font-size: 14px;
                font-weight: 600;
                color: #2e2b4a;
                line-height: 1.3;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
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
                margin-top: 4px;
            }

            .book-actions {
                padding: 10px 14px;
                display: flex;
                gap: 8px;
                border-top: 1px solid #d4d2e3;
            }

            .btn-edit {
                flex: 1;
                height: 32px;
                background: #eceaf4;
                color: #4e4798;
                border: 1px solid #c8c4e8;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                text-decoration: none;
                transition: background 0.15s;
            }

            .btn-edit:hover { background: #dddaf0; }
            .btn-edit i { font-size: 14px; }

            .btn-remove {
                flex: 1;
                height: 32px;
                background: #f5eded;
                color: #c0504a;
                border: 1px solid #e8c8c8;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                transition: background 0.15s;
            }

            .btn-remove:hover { background: #f0dede; }
            .btn-remove i { font-size: 14px; }

            /* ── Empty state ── */
            .empty-state {
                text-align: center;
                padding: 48px 24px;
                color: #9b99b8;
            }

            .empty-state i { font-size: 48px; margin-bottom: 12px; display: block; }
            .empty-state p { font-size: 14px; }

            /* ── Divider ── */
            .section-divider {
                height: 1px;
                background: #d4d2e3;
                margin: 36px 0 28px;
            }

            @media (max-width: 640px) {
                .form-grid { grid-template-columns: 1fr; }
                .field.full-width { grid-column: 1; }
                .books-grid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); }
                .page-wrapper { padding: 20px 16px 40px; }
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
                <i class="ti ti-user-circle"></i>
                Seller Dashboard
            </div>
        </nav>

        <div class="page-wrapper">

            <!-- Add Book Section -->
            <div class="section-heading">
                <i class="ti ti-circle-plus"></i>
                <h2>Add a new book</h2>
            </div>

            <div class="add-book-card">
                <form action="AddBook" method="post" enctype="multipart/form-data">
                    <div class="form-grid">

                        <div class="field">
                            <label for="booktitle">Book title</label>
                            <div class="input-wrap">
                                <i class="ti ti-books icon-left"></i>
                                <input type="text" id="booktitle" name="booktitle" placeholder="Enter title" />
                            </div>
                        </div>

                        <div class="field">
                            <label for="bookauthor">Author</label>
                            <div class="input-wrap">
                                <i class="ti ti-user icon-left"></i>
                                <input type="text" id="bookauthor" name="bookauthor" placeholder="Enter author name" />
                            </div>
                        </div>

                        <div class="field">
                            <label for="bookprice">Price (₹)</label>
                            <div class="input-wrap">
                                <i class="ti ti-currency-rupee icon-left"></i>
                                <input type="number" id="bookprice" name="bookprice" placeholder="Enter price" required />
                            </div>
                        </div>

                        <div class="field">
                            <label for="bookcondition">Condition</label>
                            <div class="input-wrap">
                                <i class="ti ti-tag icon-left"></i>
                                <select id="bookcondition" name="bookcondition">
                                    <option value="">Select condition</option>
                                    <option value="New">New</option>
                                    <option value="Old">Old</option>
                                </select>
                            </div>
                        </div>

                        <div class="field full-width file-field">
                            <label for="bookcover">Book cover image</label>
                            <input type="file" id="bookcover" name="bookcover" accept="image/*" />
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-primary">
                                <i class="ti ti-plus"></i>
                                Add book
                            </button>
                        </div>

                    </div>
                </form>
            </div>

            <div class="section-divider"></div>

            <!-- Listed Books Section -->
            <div class="section-heading">
                <i class="ti ti-layout-grid"></i>
                <h2>Your listed books</h2>
            </div>

            <%
                if (books == null || books.isEmpty()) {
            %>
            <div class="empty-state">
                <i class="ti ti-books"></i>
                <p>You haven't listed any books yet. Add your first one above!</p>
            </div>
            <%
                } else {
            %>
            <div class="books-grid">
                <%
                    for (BookDTO book : books) {
                %>
                <div class="book-card">
                    <div class="book-cover-wrap">
                        <img src="BookCoverDisplay?bookid=<%=book.getBookid()%>"
                             alt="<%=book.getBooktitle()%>"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                        <div class="no-cover" style="display:none;">
                            <i class="ti ti-book-off"></i>
                        </div>
                        <span class="condition-badge <%="New".equals(book.getBookcondition()) ? "badge-new" : "badge-old"%>">
                            <%=book.getBookcondition()%>
                        </span>
                    </div>

                    <div class="book-info">
                        <div class="book-title"><%=book.getBooktitle()%></div>
                        <div class="book-author"><%=book.getBookauthor()%></div>
                        <div class="book-price">₹<%=book.getBookprice()%></div>
                    </div>

                    <div class="book-actions">
                        <a href="EditBookServlet?bookid=<%=book.getBookid()%>" class="btn-edit">
                            <i class="ti ti-edit"></i> Edit
                        </a>
                        <form action="DeleteSellerBooks" method="post" style="flex:1; display:flex;">
                            <input type="hidden" name="bookid" value="<%=book.getBookid()%>" />
                            <button type="submit" class="btn-remove" style="width:100%;">
                                <i class="ti ti-trash"></i> Remove
                            </button>
                        </form>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>

        </div>
    </body>
</html>