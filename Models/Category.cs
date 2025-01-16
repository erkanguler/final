using System;
using System.Collections.Generic;

namespace final.Models;

public partial class Category
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? Parent { get; set; }

    public string? Path { get; set; }

    public virtual ICollection<Category> InverseParentNavigation { get; set; } = new List<Category>();

    public virtual Category? ParentNavigation { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
