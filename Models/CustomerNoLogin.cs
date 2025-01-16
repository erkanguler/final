using System;
using System.Collections.Generic;

namespace final.Models;

public partial class CustomerNoLogin
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Street { get; set; } = null!;

    public string Zipcode { get; set; } = null!;

    public string City { get; set; } = null!;

    public virtual ICollection<OrderNoLogin> OrderNoLogins { get; set; } = new List<OrderNoLogin>();
}
